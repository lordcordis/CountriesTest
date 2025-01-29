//
//  CountryCacheable.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import Foundation
import SwiftUICore

struct CountryInfoCellModel: CountryInfoCellProtocol {
    
    init(country: CountryMinimalNetworkResult) {
        self.name = country.name.official
        self.nameLocalized = country.translations["rus"]?.official ?? "unknown"
        self.flagEmoji = country.flag
        self.continents = country.continents.map({ continent in
            continent.rawValue
        })
    }
    
    let name: String
    let nameLocalized: String
    let continents: [String]
    let flagEmoji: String
    
    func visibleName(locale: LocaleData) -> String {
        switch locale {
        case .unknown:
            return name
        case .rus:
            return nameLocalized
        }
    }
}
