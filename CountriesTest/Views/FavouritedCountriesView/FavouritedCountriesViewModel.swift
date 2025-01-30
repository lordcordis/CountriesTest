//
//  FavouritedCountriesViewModel.swift
//  CountriesTest
//
//  Created by Роман on 31.01.2025.
//

import SwiftUI

final class FavouritedCountriesViewModel: ObservableObject {
    
    // Published list of favourited countries
    @Published var countries: [CountryCacheable] = []
    
    // Initialize and load data
    init() {
        loadData()
    }
    
    // Load data into the view model
    func loadData() {
        fetchCountriesFromCoreData()
    }
    
    // Remove a country from the list and Core Data
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
    
    // Fetch countries from Core Data
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
