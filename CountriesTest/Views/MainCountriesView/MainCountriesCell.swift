//
//  MainCountriesCell.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct MainCountriesCell: View {
    
    let country: CountryInfoCellProtocol
    let localeCell: LocaleData
    
    init(countryCacheable: CountryInfoCellProtocol, localeCell: LocaleData) {
        self.country = countryCacheable
        self.localeCell = localeCell
    }
    
    var body: some View {
        GroupBox {
            
            HStack {
                Text(country.flagEmoji)
                    .font(.title)
                    .padding(.trailing)
                VStack(alignment: .leading) {
                    switch localeCell {
                    case .rus:
                        Text(country.nameLocalized)
                    case .otherThanRus:
                        Text(country.name)
                    }
                    
                    
                    Text(country.continents.description)
                }
                Spacer()
            }
            
        }
    }
}
