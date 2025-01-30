//
//  Untitled.swift
//  CountriesTest
//
//  Created by Роман on 31.01.2025.
//

import SwiftUI

// View to display continents of the country
struct ContinentsView: View {
    
    let locale = LocaleManager.getLocale()
    
    init(continents: [String]) {
        switch locale {
        case .rus:
            // Map continents to Russian names
            var continentKeys = [String]()
            continents.forEach { continentString in
                if let continentEnum = Continent(rawValue: continentString) {
                    let key = continentEnum.russianText()
                    continentKeys.append(key)
                }
            }
            textString = continentKeys.joined(separator: ", ") // Join Russian continent names
            
        case .otherThanRus:
            textString = continents.joined(separator: ", ") // Join default continent names
        }
    }
    
    var textString = ""
    
    var body: some View {
        Text(textString) // Display continent names
            .font(.subheadline)
    }
}
