//
//  countryFull.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countryFullNetworkResult = try? JSONDecoder().decode(CountryFullNetworkResult.self, from: jsonData)

import Foundation

// MARK: - CountryFullNetworkResultElement
struct CountryFullNetworkResultElement: Codable {
    let flags: Flags
    let name: Name
    let currencies: [String: Currency]
    let capital: [String]
    let languages: [String: String]
    let latlng: [Double]
    let area: Double
    let population: Int
    let timezones: [String]
    
    // MARK: - Currency
    struct Currency: Codable {
        let name, symbol: String
    }

    // MARK: - Flags
    struct Flags: Codable {
        let png: String
        let svg: String
        let alt: String
    }

    // MARK: - Name
    struct Name: Codable {
        let common, official: String
        let nativeName: [String: NativeName]
    }

    // MARK: - NativeName
    struct NativeName: Codable {
        let official, common: String
    }
}


