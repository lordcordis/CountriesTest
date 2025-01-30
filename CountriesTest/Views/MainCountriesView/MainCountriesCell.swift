//
//  MainCountriesCell.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI

// Cell view for displaying country information
struct MainCountriesCell: View {
    
    let country: CountryInfoCellProtocol
    let localeCell: LocaleData
    
    init(countryCacheable: CountryInfoCellProtocol, localeCell: LocaleData) {
        self.country = countryCacheable
        self.localeCell = localeCell
    }
    
    var body: some View {
        GroupBox { // GroupBox for containing country data
            HStack {
                Text(country.flagEmoji) // Display country flag emoji
                    .font(.title)
                    .padding(.trailing)
                VStack(alignment: .leading) {
                    // Switch name display based on locale
                    switch localeCell {
                    case .rus:
                        Text(country.nameLocalized) // Display localized name
                    case .otherThanRus:
                        Text(country.name) // Display official name
                    }
                    // Show list of continents for the country
                    ContinentsView(continents: country.continents)
                }
                Spacer()
            }
        }
    }
}

