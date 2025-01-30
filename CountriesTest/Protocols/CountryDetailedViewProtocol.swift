//
//  CountryDetailedViewProtocol.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

// Protocol defining the required properties for detailed country information
protocol CountryDetailedViewProtocol {
    var name: String {get}             // Country name
    var nameLocalized: String {get}    // Localized country name
    var currencyString: String {get}   // Currency details
    var timeZones: String {get}        // Time zones
    var capital: String {get}          // Capital city
    var population: Int {get}          // Population
    var area: Double {get}             // Area in square kilometers
    var latitude: Double {get}         // Latitude
    var longitude: Double {get}        // Longitude
    var flagEmoji: String {get}        // Flag emoji
    var flagPng: String {get}          // Flag PNG URL
    var continents: [String] {get}     // List of continents
}
