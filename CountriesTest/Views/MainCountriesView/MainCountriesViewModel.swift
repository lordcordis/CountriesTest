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
        
        self.localeCell = LocaleManager.getLocale()
        
        super.init()
        
        self.coordinator = coordinator
        
        setup()
        
    }
    
    var coordinator: Coordinator?
    
    var localeCell: LocaleData
    
    var networkManager: NetworkManager
    
    @Published var alertIsActive = false
    @Published var alertText = ""
    @Published var loadingIndicator: loadingIndicator = .notLoading
    @Published var forcedOfflineMode = false
    
    func presentAlert(text: String) {
        DispatchQueue.main.async {
            self.alertText = text
            self.alertIsActive.toggle()
        }
    }
    
    func setup() {
        Task {
            do {
                try await loadCitiesMainList()
            } catch {
                presentAlert(text: error.localizedDescription)
            }
        }
    }
    
    func loadCitiesMainList() async throws {
        
        changeLoadingStatus(to: .loading)
        
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
            countryListFilterable = res
            countryListFull = res
            changeLoadingStatus(to: .notLoading)
        }
    }
    
    @Published var countryListFilterable = [any CountryInfoCellProtocol]()
    var countryListFull = [any CountryInfoCellProtocol]()
    
    @Published var searchInput = ""
    @Published var searchEnabled = false
    
    func filterCountries() {
        if searchEnabled {
            
            let filtered = countryListFull.filter { countryCacheable in
                switch localeCell {
                case .rus:
                    countryCacheable.nameLocalized.lowercased().contains(searchInput.lowercased())
                case .otherThanRus:
                    countryCacheable.name.lowercased().contains(searchInput.lowercased())
                }
                
            }
            DispatchQueue.main.async {
                self.countryListFilterable = filtered
            }
            
        } else {
            DispatchQueue.main.async {
                self.countryListFilterable = self.countryListFull
            }
        }
    }
    
    func countryCellTapped(country: CountryInfoCellProtocol) {
        Task {
            do {
                try await presentCountryFullView(country: country)
            } catch {
                presentAlert(text: error.localizedDescription)
            }
        }
    }
    
    func retryLoadingDataButtonPressed() {
        setup()
    }
    
    private func changeLoadingStatus(to: loadingIndicator) {
        DispatchQueue.main.async {
            self.loadingIndicator = to
        }
    }
    
    private func presentCountryFullView(country: CountryInfoCellProtocol) async throws {
        
        changeLoadingStatus(to: .loading)
        
        defer {
            changeLoadingStatus(to: .notLoading)
        }
        
        guard let apiEndpoint = Bundle.main.object(forInfoDictionaryKey:"API_URL_COUNTRY_SEARCH") as? String,
        let queries = Bundle.main.object(forInfoDictionaryKey:"API_URL_COUNTRY_SEARCH_QUERIES") as? String
        else {
            throw NetworkError.missingKey
        }
        
        guard let url = URL(string: apiEndpoint) else {
            throw NetworkError.badURL
        }
        
        let newURL = url
            .appendingPathComponent(country.name, conformingTo: .data)
        
        let queryItems = [
            URLQueryItem(name: "fields", value: queries)
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


