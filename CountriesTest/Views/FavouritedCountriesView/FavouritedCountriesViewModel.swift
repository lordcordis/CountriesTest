//
//  FavouritedCountriesViewModel.swift
//  CountriesTest
//
//  Created by Роман on 31.01.2025.
//

import SwiftUI

final class FavouritedCountriesViewModel: ObservableObject {
    
    @Published var countries: [CountryCacheable] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        fetchCountriesFromCoreData()
    }
    
    func removeCountry(countryToDelete: CountryCacheable) {
        do {
            if let firstIndex = countries.firstIndex(where: { country in
                country.name == countryToDelete.name
            }) {
                do {
                    try CoreDataManager.shared.deleteCountry(countryName: countryToDelete.name)
                    countries.remove(at: firstIndex)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchCountriesFromCoreData() {
        do {
            if let countriesRetrieved = try CoreDataManager.shared.retrieveSavedCountries() {
                self.countries = countriesRetrieved
            } else {
                self.countries = []
            }
        } catch {
            self.countries = []
            print("Failed to load countries: \(error.localizedDescription)")
        }
    }
}
