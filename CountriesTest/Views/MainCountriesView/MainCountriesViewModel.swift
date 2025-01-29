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
        
        let countries: [Country]? = try await networkManager.fetchData(url: url)
        
        guard let countries = countries else {
            throw NetworkManagerError.listIsEmpty
        }
        
        print(countries)
        
        await MainActor.run {
            self.countriesFullList.append(contentsOf: countries)
        }
        
        
        
    }
    
//    var countries = [Country]()
    @Published var countriesFullList = [Country]()
//    @Published var countriesFilteredList = [Country]()
    
    @Published var searchInput = ""
    @Published var searchEnabled = false

    
}
