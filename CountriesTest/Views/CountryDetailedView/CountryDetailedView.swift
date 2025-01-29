//
//  CountryDetailedView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct CountryDetailedView: View {
    
    init(country: CountryFullNetworkResponseRight, localizedName: String) {
        self.country = country
        self.localizedName = localizedName
        var output = ""
        country.currencies.forEach({ _, currencyBody in
            if !output.isEmpty {
                output.append(", ")
            }
            
            output.append("\(currencyBody.name): \(currencyBody.symbol)")
        })
        self.currencyString = output
        self.localeCell = LocaleManager.getLocale()
    }
    
    let localeCell: LocaleCell
    let localizedName: String
    let country: CountryFullNetworkResponseRight
    var currencyString: String
    
    var body: some View {
        
        switch localeCell {
        case .rus:
            Text("Official name: \(localizedName)")
                .font(.headline)
                .padding()
        case .unknown:
            Text("Official name: \(country.name.official)")
                .font(.headline)
                .padding()
        }
        
        Divider()
        
        Text("Capital: \(country.capital.first ?? "unknown")")
        Text("Population: \(country.population)")
        Text("Area: \(country.area)")
        Text("Currency: \(currencyString)")
        MapView(latitude: country.latlng.first!, longitude: country.latlng.last!)
        AsyncImage(url: URL(string: country.flags.png))
        
        Spacer()
    }
}
