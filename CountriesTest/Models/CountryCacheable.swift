//
//  CountryCacheable.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import Foundation

struct CountryCacheable: CountryInfoCellProtocol, CountryDetailedViewProtocol {
    
    init?(countryFullNetworkResult: CountryFullNetworkResult, localizedName: String) {
        
        self.name = countryFullNetworkResult.name.official
        self.nameLocalized = localizedName
        self.currencyString = countryFullNetworkResult.currencies
            .map { _, currency in
                return "\(currency.name): \(currency.symbol)"
            }
            .joined(separator: ", ")
        
        self.timeZones = countryFullNetworkResult.timezones.map { $0
        }.joined(separator: ", ")
        
        guard let capital = countryFullNetworkResult.capital.first else {
            return nil
        }
        
        self.capital = capital
        self.population = countryFullNetworkResult.population
        self.area = countryFullNetworkResult.area
        self.flagEmoji = countryFullNetworkResult.flag
        self.flagPng = countryFullNetworkResult.flags.png
        self.continents = countryFullNetworkResult.continents.map({ continent in
            continent.rawValue
        })
        
        guard let latitude = countryFullNetworkResult.latlng.first, let longitude =  countryFullNetworkResult.latlng.last else {
            return nil
        }

        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    let name: String
    let nameLocalized: String
    var currencyString: String
    var timeZones: String
    let capital: String
    let population: Int
    let area: Double
    let latitude: Double
    let longitude: Double
    let flagEmoji: String
    let flagPng: String
    let continents: [String]
}
