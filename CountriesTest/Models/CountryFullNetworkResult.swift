////
////  CountryFullNetworkResult.swift
////  CountriesTest
////
////  Created by Роман on 29.01.2025.
////
//
//import Foundation
//import Foundation
//
//struct CountryFullNetworkResult: Codable {
//    let flags: Flags
//    let name: Name
//    let currencies: [String: Currency]
//    let capital: [String]
//    let languages: [String: String]
//    let latlng: [Double]
//    let area: Double
//    let population: Int
//    let timezones: [String]
//    
//    struct Flags: Codable {
//        let png: String
//        let svg: String
//        let alt: String?
//    }
//    
//    struct Name: Codable {
//        let common: String
//        let official: String
//        let nativeName: [String: NativeName]
//    }
//    
//    struct NativeName: Codable {
//        let official: String
//        let common: String
//    }
//    
//    struct Currency: Codable {
//        let name: String
//        let symbol: String
//    }
//}
