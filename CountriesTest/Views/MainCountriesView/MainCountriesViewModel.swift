//
//  MainCountriesViewModel.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import Foundation

final class MainCountriesViewModel: NSObject, ObservableObject {
    
    // Initializer with networkManager and coordinator
    init(networkManager: NetworkManager, coordinator: Coordinator?) {
        
        self.networkManager = networkManager
        self.localeCell = LocaleManager.getLocale()
        
        super.init()
        
        self.coordinator = coordinator
        setup()
    }
    
    // Coordinator for navigation
    var coordinator: Coordinator?
    
    // Locale data (language preferences)
    var localeCell: LocaleData
    
    // Network manager to fetch data
    var networkManager: NetworkManager
    
    // Published variables for UI updates
    @Published var alertIsActive = false
    @Published var alertText = ""
    @Published var loadingIndicator: loadingIndicator = .notLoading
    @Published var forcedOfflineMode = false
    
    // Country list data
    @Published var countryListFilterable = [any CountryInfoCellProtocol]()
    var countryListFull = [any CountryInfoCellProtocol]()
    
    // Search functionality
    @Published var searchInput = ""
    @Published var searchEnabled = false
    
    // Show alert
    func presentAlert(text: String) {
        DispatchQueue.main.async {
            self.alertText = text
            self.alertIsActive.toggle()
        }
    }
    
    // Setup function to load country data
    func setup() {
        Task {
            do {
                try await loadCitiesMainList()
            } catch {
                presentAlert(text: error.localizedDescription)
            }
        }
    }
    
    // Filter countries based on search input
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
    
    // Handle country cell tap
    func countryCellTapped(country: CountryInfoCellProtocol) {
        Task {
            do {
                try await presentCountryFullView(country: country)
            } catch {
                presentAlert(text: error.localizedDescription)
            }
        }
    }
    
    // Retry loading data
    func retryLoadingDataButtonPressed() {
        setup()
    }
    
    // Update loading status
    private func changeLoadingStatus(to: loadingIndicator) {
        DispatchQueue.main.async {
            self.loadingIndicator = to
        }
    }
    
    // Load list of countries
    private func loadCitiesMainList() async throws {
        
        changeLoadingStatus(to: .loading)
        
        guard let apiEndpoint = Bundle.main.object(forInfoDictionaryKey:"API_URL_MAIN_SCREEN") as? String else {
            throw NetworkError.missingKey
        }
        
        guard let url = URL(string: apiEndpoint) else {
            throw URLError(.badURL)
        }
        
        let countries: [CountryMinimalNetworkResult]? = try await networkManager.fetchData(url: url)
        
        guard let countries = countries else {
            throw URLError(.badServerResponse)
        }
        
        let res = countries.map { CountryInfoCellModel(country: $0)}
        
        await MainActor.run {
            countryListFilterable = res
            countryListFull = res
            changeLoadingStatus(to: .notLoading)
        }
    }
    
    // Present detailed country view
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
            throw URLError(.badURL)
        }
        
        let urlCountryBase = url
            .appendingPathComponent(country.name, conformingTo: .data)
        
        let queryItems = [
            URLQueryItem(name: "fields", value: queries)
        ]
        
        let urlWithQueries = urlCountryBase.appending(queryItems: queryItems)
        
        let chosenCountryResponse: [CountryFullNetworkResult]? = try await networkManager.fetchData(url: urlWithQueries)
        guard let chosenCountry = chosenCountryResponse?.first else {
            throw URLError(.badServerResponse)
        }
        
        guard let result = CountryCacheable(countryFullNetworkResult: chosenCountry, localizedName: country.nameLocalized) else {
            throw URLError(.cannotParseResponse)
        }
        
        coordinator?.presentDetailedView(country: result, localizedName: country.nameLocalized, origin: .fullList)
    }
}
