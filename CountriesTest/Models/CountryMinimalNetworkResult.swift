// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countries = try? JSONDecoder().decode(Countries.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - Country
// Model representing minimal country information from the network result
struct CountryMinimalNetworkResult: Codable {
    let flags: Flags         // Flags information of the country
    let name: Name           // Name of the country
    let translations: [String: Translation] // Translations of country name
    let flag: String         // Flag emoji of the country
    let continents: [Continent] // Continent(s) the country belongs to
}

// MARK: - Continent
// Enum for representing continents
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
// Model representing the flag information (PNG, SVG, and alternative)
struct Flags: Codable {
    let png: String         // URL of PNG flag image
    let svg: String         // URL of SVG flag image
    let alt: String         // Alternative text for the flag
}

// MARK: - Name
// Model representing the country's name, including common and official names
struct Name: Codable {
    let common, official: String       // Common and official name of the country
    let nativeName: [String: Translation] // Translations of the country name in different languages
}

// MARK: - Translation
// Model for translating the country name to other languages
struct Translation: Codable {
    let official, common: String      // Translated official and common names
}

// Type alias for an array of countries
typealias Countries = [CountryMinimalNetworkResult]
