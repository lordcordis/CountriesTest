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
        
        if Locale.current.identifier == "ru_RU" {
            self.localeCell = .rus
        } else {
            self.localeCell = .unknown
        }
        
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
    
    var localeCell: LocaleCell
    
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
        
        let countries: [CountryNetworkResult]? = try await networkManager.fetchData(url: url)
        
        guard let countries = countries else {
            throw NetworkError.listIsEmpty
        }
        
        let res = countries.map { CountryCacheable(country: $0)}
        await MainActor.run {
            countryCacheableList = res
            countryCacheableListBackup = res
        }
    }
    
    @Published var countryCacheableList = [any CountryCacheableProtocol]()
    var countryCacheableListBackup = [any CountryCacheableProtocol]()
    
    @Published var searchInput = ""
    @Published var searchEnabled = false
    
    func filterCountries() {
        if searchEnabled {
            
            let filtered = countryCacheableListBackup.filter { countryCacheable in
                switch localeCell {
                case .rus:
//                    countryCacheable.nameLocalized.contains(searchInput)
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
    
    func countryCellTapped(country: CountryCacheableProtocol) {
        Task {
            try? await presentCountryFullView(country: country)
        }
    }
    
    func retryLoadingDataButtonPressed() {
        setup()
    }
    
    private func presentCountryFullView(country: CountryCacheableProtocol) async throws {
        print(country.name)
        
        
        guard let apiEndpoint = Bundle.main.object(forInfoDictionaryKey:"API_URL_COUNTRY_SEARCH") as? String else {
            throw NetworkError.missingKey
        }
        
        guard let url = URL(string: apiEndpoint) else {
            throw NetworkError.badURL
        }
        
        let newURL = url
            .appendingPathComponent(country.name, conformingTo: .data)
        
        let queryItems = [
            URLQueryItem(name: "fields", value: "official,name,capital,population,area,currencies,languages,timezones,latlng,flags")
        ]
        
        let newnew = newURL.appending(queryItems: queryItems)
        print(newnew)
        let countryFull: [CountryFullNetworkResponseRight]? = try await networkManager.fetchData(url: newnew)
        guard let chosenCounry = countryFull?.first else {
            return
        }
        
        print(chosenCounry)
        
        coordinator?.presentDetailedView(country: chosenCounry)
        
    }

    
}
