//
//  CountryCacheable.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import Foundation

// Structure that holds country data, conforming to two protocols: CountryInfoCellProtocol and CountryDetailedViewProtocol
struct CountryCacheable: CountryInfoCellProtocol, CountryDetailedViewProtocol {
    
    // Initializer to create a CountryCacheable object from a cached entity
    init?(cacheableEntity: CountryCacheableEntity) {
        
        // Safely unwrap the values from the cached entity
        guard let name = cacheableEntity.name,
              let nameLocalized = cacheableEntity.nameLocalized,
              let currencyString = cacheableEntity.currencyString,
              let timeZones: String = cacheableEntity.timeZones,
              let capital = cacheableEntity.capital,
              let flagEmoji: String = cacheableEntity.flagEmoji,
              let flagPng: String = cacheableEntity.flagPng,
              let continents: [String] = cacheableEntity.continents?.components(separatedBy: ",") else
        { return nil } // Return nil if any required value is missing
        
        // Assign values to properties
        self.name = name
        self.nameLocalized = nameLocalized
        self.currencyString = currencyString
        self.timeZones = timeZones
        self.capital = capital
        self.flagPng = flagPng
        self.flagEmoji = flagEmoji
        self.area = cacheableEntity.area
        self.latitude = cacheableEntity.latitude
        self.longitude = cacheableEntity.longitude
        self.population = Int(cacheableEntity.population) // Convert population to an integer
        self.continents = continents
    }
    
    // Initializer to create a CountryCacheable object from a full network result and localized name
    init?(countryFullNetworkResult: CountryFullNetworkResult, localizedName: String) {
        
        // Assign values from the network result to properties
        self.name = countryFullNetworkResult.name.official
        self.nameLocalized = localizedName
        self.currencyString = countryFullNetworkResult.currencies
            .map { _, currency in
                return "\(currency.name): \(currency.symbol)"
            }
            .joined(separator: ", ") // Join multiple currencies into a string
        
        self.timeZones = countryFullNetworkResult.timezones.map { $0 }
            .joined(separator: ", ") // Join multiple timezones into a string
        
        // Ensure the capital is available
        guard let capital = countryFullNetworkResult.capital.first else {
            return nil // Return nil if no capital is found
        }
        
        self.capital = capital
        self.population = countryFullNetworkResult.population
        self.area = countryFullNetworkResult.area
        self.flagEmoji = countryFullNetworkResult.flag
        self.flagPng = countryFullNetworkResult.flags.png
        self.continents = countryFullNetworkResult.continents.map({ continent in
            continent.rawValue
        }) // Convert continent enum values to string
        
        // Ensure latitude and longitude are available
        guard let latitude = countryFullNetworkResult.latlng.first, let longitude =  countryFullNetworkResult.latlng.last else {
            return nil // Return nil if latitude or longitude are missing
        }

        self.latitude = latitude
        self.longitude = longitude
    }
    
    // Properties to hold country information
    let name: String
    let nameLocalized: String
    let currencyString: String
    let timeZones: String
    let capital: String
    let population: Int
    let area: Double
    let latitude: Double
    let longitude: Double
    let flagEmoji: String
    let flagPng: String
    let continents: [String]
}
