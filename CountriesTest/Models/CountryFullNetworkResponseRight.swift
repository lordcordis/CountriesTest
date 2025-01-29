//
//  swiss.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import Foundation

struct CountryFullNetworkResponseRight: Codable {
    let name: Name
    let capital: [String]
    let population: Int
    let area: Double
    let currencies: [String: Currency]
    let languages: [String: String]
    let timezones: [String]
    let latlng: [Double]
    let flags: Flags
    
    struct Name: Codable {
        let official: String
        let common: String
    }

    struct Currency: Codable {
        let name: String
        let symbol: String
    }

    struct Flags: Codable {
        let png: String
        let svg: String
    }
}


