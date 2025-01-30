// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countries = try? JSONDecoder().decode(Countries.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - Country
struct CountryMinimalNetworkResult: Codable {
    let flags: Flags
    let name: Name
    let translations: [String: Translation]
    let flag: String
    let continents: [Continent]
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

extension Continent {
    func russianText() -> String {
        switch self {
        case .africa:
            "Африка"
        case .antarctica:
            "Антарктида"
        case .asia:
            "Азия"
        case .europe:
            "Европа"
        case .northAmerica:
            "Северная Америка"
        case .oceania:
            "Океания"
        case .southAmerica:
            "Южная Америка"
        }
    }
}

extension Continent {
    func localizedStringKey() -> LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
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
    let nativeName: [String: Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

typealias Countries = [CountryMinimalNetworkResult]
