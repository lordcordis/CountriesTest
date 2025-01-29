//
//  CountryDetailedView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct CountryDetailedView: View {
    
    init(country: CountryFullNetworkResponseRight) {
        self.country = country
        
        var output = ""
        country.currencies.forEach({ _, currencyBody in
            if !output.isEmpty {
                output.append(", ")
            }
            
            output.append("\(currencyBody.name): \(currencyBody.symbol)")
        })
        self.currencyString = output
    }
    
    let country: CountryFullNetworkResponseRight
    var currencyString: String
    
    var body: some View {
        Text("Official name: \(country.name.official)")
        Text("Capital: \(country.capital.first ?? "unknown")")
        Text("Population: \(country.population)")
        Text("Area: \(country.area)")
        Text("Currency: \(currencyString)")
    }
}
