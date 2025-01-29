//
//  MainCountriesViewModel.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import Foundation

final class MainCountriesViewModel: NSObject, ObservableObject {
    
    
    
    init(networkManager: NetworkManager) {
        
        self.networkManager = networkManager
        
        if Locale.current.identifier == "ru_RU" {
            self.localeCell = .rus
        } else {
            self.localeCell = .unknown
        }
        
        print(localeCell)
        
        
        super.init()
        
        networkManager.delegate = self
        
        
        
        Task {
            do {
                try await setup()
            } catch {
                print(error)
            }
            
            
        }
        
    }
    
    var localeCell: LocaleCell
    
    var networkManager: NetworkManager
    
    func setup() async throws {
        
        guard let apiEndpoint = Bundle.main.object(forInfoDictionaryKey:"API_URL_MAIN_SCREEN") as? String else {
            throw NetworkManagerError.missingKey
        }
        
        guard let url = URL(string: apiEndpoint) else {
            throw NetworkManagerError.badURL
        }
        
        let countries: [CountryNetworkResult]? = try await networkManager.fetchData(url: url)
        
        guard let countries = countries else {
            throw NetworkManagerError.listIsEmpty
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
                    countryCacheable.nameLocalized.contains(searchInput)
                case .unknown:
                    countryCacheable.name.contains(searchInput)
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

    
}
