//
//  CountryDetailedView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct CountryDetailedView: View {
    
    init(countryCacheable: CountryCacheable) {
        self.localeData = LocaleManager.getLocale()
        self.countryCacheable = countryCacheable
        self.name = countryCacheable.name
        self.nameLocalized = countryCacheable.nameLocalized
        self.currencyString = countryCacheable.currencyString
        self.timeZones = countryCacheable.timeZones
        self.capital = countryCacheable.capital
        self.area = countryCacheable.area
        self.population = countryCacheable.population
        self.continents = countryCacheable.continents
        self.flagPng = countryCacheable.flagPng
        self.latitude = countryCacheable.latitude
        self.longitude = countryCacheable.longitude
    }
    
    let countryCacheable: CountryCacheable
    
    let localeData: LocaleData
    
    let name: String
    let nameLocalized: String
    let currencyString: String
    let timeZones: String
    let capital: String
    let population: Int
    let area: Double
    let latitude: Double
    let longitude: Double
    let flagPng: String
    let continents: [String]
    
    var body: some View {
        
        switch localeData {
        case .rus:
            Text("\(nameLocalized)")
                .font(.headline)
                .padding()
        case .unknown:
            Text("\(name)")
                .font(.headline)
                .padding()
        }
        
        Divider()
        
        Text("Capital: \(capital)")
        Text("Population: \(population)")
        Text("Area: \(area)")
        Text("Currency: \(currencyString)")
        Text("Timezones: \(timeZones)")
        MapView(latitude: latitude, longitude: longitude)
        AsyncImage(url: URL(string: flagPng))
        
        Spacer()
    }
}
