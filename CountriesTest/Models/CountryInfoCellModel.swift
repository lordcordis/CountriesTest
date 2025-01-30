//
//  CountryCacheable.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import Foundation
import SwiftUICore

// Model for country information displayed in the country info cell
struct CountryInfoCellModel: CountryInfoCellProtocol {
    
    // Initializer to create a CountryInfoCellModel from a minimal network result
    init(country: CountryMinimalNetworkResult) {
        // Set the official name of the country
        self.name = country.name.official
        // Set the localized name for Russian if available, otherwise default to "unknown"
        self.nameLocalized = country.translations["rus"]?.official ?? "unknown"
        // Set the flag emoji for the country
        self.flagEmoji = country.flag
        // Map the continents array into a string array with continent raw values
        self.continents = country.continents.map({ continent in
            continent.rawValue
        })
    }
    
    // Properties to store the country details
    let name: String
    let nameLocalized: String
    let continents: [String]
    let flagEmoji: String
    
    // Function to return the country name based on the locale
    func visibleName(locale: LocaleData) -> String {
        switch locale {
        case .otherThanRus:
            return name  // Return the official name for non-Russian locales
        case .rus:
            return nameLocalized  // Return the localized name for Russian locale
        }
    }
}
