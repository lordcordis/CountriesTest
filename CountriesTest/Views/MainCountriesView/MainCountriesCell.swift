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
                    
                    
                    ContinentsView(continents: country.continents)
                }
                Spacer()
            }
            
        }
    }
}

struct ContinentsView: View {
    
    let locale = LocaleManager.getLocale()
    
    init(continents: [String]) {
        
        switch locale {
        case .rus:
            
            var continentKeys = [String]()
            continents.forEach { continentString in
                if let continentEnum = Continent(rawValue: continentString) {
                    let key = continentEnum.russianText()
                    continentKeys.append(key)
                }
            }
            textString = continentKeys.joined(separator: ", ")
            
            
        case .otherThanRus:
            textString = continents.joined(separator: ", ")
        }
        
        
        
    }
    
    var textString = ""
    
    
    var body: some View {
        Text(textString)
            .font(.subheadline)
    }
}
