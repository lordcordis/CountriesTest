//
//  MainCountriesViewModel.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import Foundation

final class MainCountriesViewModel: NSObject, ObservableObject {
    
    init(networkManager: NetworkManager, coordinator: Coordinator?) {
        
        self.networkManager = networkManager
        
//        if Locale.current.identifier == "ru_RU" {
//            self.localeCell = .rus
//        } else {
//            self.localeCell = .unknown
//        }
        
        self.localeCell = LocaleManager.getLocale()
        
        print(localeCell)
        
        
        super.init()
        
        networkManager.delegate = self
        self.coordinator = coordinator
        
        
        setup()
        
    }
    
    var coordinator: Coordinator?
    
    @Published var alertIsActive = false
    @Published var alertText = ""
    
    func presentError(text: String) {
        DispatchQueue.main.async {
            self.alertText = text
            self.alertIsActive.toggle()
        }
    }
    
    var localeCell: LocaleData
    
    var networkManager: NetworkManager
    
    func setup() {
        Task {
            do {
                try await loadCitiesMainList()
            } catch {
                print(error.localizedDescription)
                presentError(text: error.localizedDescription)
            }
        }
    }
    
    func loadCitiesMainList() async throws {
        
        guard let apiEndpoint = Bundle.main.object(forInfoDictionaryKey:"API_URL_MAIN_SCREEN") as? String else {
            throw NetworkError.missingKey
        }
        
        guard let url = URL(string: apiEndpoint) else {
            throw NetworkError.badURL
        }
        
        let countries: [CountryMinimalNetworkResult]? = try await networkManager.fetchData(url: url)
        
        guard let countries = countries else {
            throw NetworkError.listIsEmpty
        }
        
        let res = countries.map { CountryInfoCellModel(country: $0)}
        await MainActor.run {
            countryCacheableList = res
            countryCacheableListBackup = res
        }
    }
    
    @Published var countryCacheableList = [any CountryInfoCellProtocol]()
    var countryCacheableListBackup = [any CountryInfoCellProtocol]()
    
    @Published var searchInput = ""
    @Published var searchEnabled = false
    
    func filterCountries() {
        if searchEnabled {
            
            let filtered = countryCacheableListBackup.filter { countryCacheable in
                switch localeCell {
                case .rus:
                    countryCacheable.nameLocalized.lowercased().contains(searchInput.lowercased())
                case .unknown:
                    countryCacheable.name.lowercased().contains(searchInput.lowercased())
                }
                
            }
            DispatchQueue.main.async {
                self.countryCacheableList = filtered
            }
            
        } else {
            DispatchQueue.main.async {
                self.countryCacheableList = self.countryCacheableListBackup
            }
        }
    }
    
    func countryCellTapped(country: CountryInfoCellProtocol) {
        Task {
            try? await presentCountryFullView(country: country)
        }
    }
    
    func retryLoadingDataButtonPressed() {
        setup()
    }
    
    private func presentCountryFullView(country: CountryInfoCellProtocol) async throws {
        
        guard let apiEndpoint = Bundle.main.object(forInfoDictionaryKey:"API_URL_COUNTRY_SEARCH") as? String else {
            throw NetworkError.missingKey
        }
        
        guard let url = URL(string: apiEndpoint) else {
            throw NetworkError.badURL
        }
        
        let newURL = url
            .appendingPathComponent(country.name, conformingTo: .data)
        
        let queryItems = [
            URLQueryItem(name: "fields", value: "official,name,capital,population,area,currencies,languages,timezones,latlng,flags,flag,continents")
        ]
        
        let newnew = newURL.appending(queryItems: queryItems)
        
        let chosenCountryResponse: [CountryFullNetworkResult]? = try await networkManager.fetchData(url: newnew)
        guard let chosenCountry = chosenCountryResponse?.first else {
            throw NetworkError.badResponse
        }
        
        guard let result = CountryCacheable(countryFullNetworkResult: chosenCountry, localizedName: country.nameLocalized) else {
            throw NetworkError.badResponse
        }
        
        coordinator?.presentDetailedView(country: result, localizedName: country.nameLocalized, origin: .fullList)
        
    }

    
}
