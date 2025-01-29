//
//  CountryDetailedView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct CountryDetailedView: View {
    
    init(country: CountryFullNetworkResult, localizedName: String) {
        self.country = country
        self.localizedName = localizedName
        
        self.currencyString = country.currencies
            .map { _, currency in
                return "\(currency.name): \(currency.symbol)"
            }
            .joined(separator: ", ")
        
        self.localeData = LocaleManager.getLocale()
        
        self.timeZones = country.timezones.map { $0
        }.joined(separator: ", ")
    }
    
    let localeData: LocaleData
    let localizedName: String
    let country: CountryFullNetworkResult
    var currencyString: String
    var timeZones: String
    
    var body: some View {
        
        switch localeData {
        case .rus:
            Text("\(localizedName)")
                .font(.headline)
                .padding()
        case .unknown:
            Text("\(country.name.official)")
                .font(.headline)
                .padding()
        }
        
        Divider()
        
        Text("Capital: \(country.capital.first ?? "unknown")")
        Text("Population: \(country.population)")
        Text("Area: \(country.area)")
        Text("Currency: \(currencyString)")
        Text("Timezones: \(timeZones)")
        MapView(latitude: country.latlng.first!, longitude: country.latlng.last!)
        AsyncImage(url: URL(string: country.flags.png))
        
        Spacer()
    }
}
