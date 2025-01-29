// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countries = try? JSONDecoder().decode(Countries.self, from: jsonData)

import Foundation

// MARK: - Country
struct Country: Codable {
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

typealias Countries = [Country]
