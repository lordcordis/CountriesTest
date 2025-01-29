//
//  CountryCacheable.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import Foundation
import SwiftUICore

protocol CountryCacheableProtocol {
    var name: String {get}
    var nameLocalized: String {get}
    var continents: [String] {get}
    var flagEmoji: String {get}
}

struct CountryCacheable: CountryCacheableProtocol {
    
    init(country: CountryNetworkResult) {
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
    
    func visibleName(locale: LocaleCell) -> String {
        switch locale {
        case .unknown:
            return name
        case .rus:
            return nameLocalized
        }
    }
}
