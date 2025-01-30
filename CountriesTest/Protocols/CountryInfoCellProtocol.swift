//
//  CountryInfoCellProtocol.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//
import SwiftUI

// Protocol defining the required properties for country info cell
protocol CountryInfoCellProtocol {
    var name: String {get}             // Country name
    var nameLocalized: String {get}    // Localized country name
    var continents: [String] {get}     // List of continents
    var flagEmoji: String {get}        // Flag emoji
}
