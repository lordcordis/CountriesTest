//
//  swiss.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import Foundation

// Struct representing the full network result for country data
struct CountryFullNetworkResult: Codable {
    
    // Basic country information
    let name: Name
    let capital: [String]
    let population: Int
    let area: Double
    let currencies: [String: Currency]
    let languages: [String: String]
    let timezones: [String]
    let latlng: [Double]
    let flags: Flags
    let flag: String
    let continents: [Continent]
    
    // Nested struct for country name information
    struct Name: Codable {
        let official: String
        let common: String
    }

    // Nested struct for currency details
    struct Currency: Codable {
        let name: String
        let symbol: String
    }

    // Nested struct for flag URLs (PNG and SVG)
    struct Flags: Codable {
        let png: String
        let svg: String
    }
}
