//
//  CountryInfoCellProtocol.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//


protocol CountryInfoCellProtocol {
    var name: String {get}
    var nameLocalized: String {get}
    var continents: [String] {get}
    var flagEmoji: String {get}
}


