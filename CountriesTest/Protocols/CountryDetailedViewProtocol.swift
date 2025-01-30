//
//  CountryDetailedViewProtocol.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//


protocol CountryDetailedViewProtocol {
    var name: String {get}
    var nameLocalized: String {get}
    var currencyString: String {get}
    var timeZones: String {get}
    var capital: String {get}
    var population: Int {get}
    var area: Double {get}
    var latitude: Double {get}
    var longitude: Double {get}
    var flagEmoji: String {get}
    var flagPng: String {get}
    var continents: [String] {get}
}