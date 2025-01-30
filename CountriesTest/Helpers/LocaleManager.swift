//
//  LocaleManager.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//
import Foundation

struct LocaleManager {
    static func getLocale() -> LocaleData {
        if Locale.current.identifier == "ru_RU" {
            return .rus
        } else {
            return .otherThanRus
        }
    }
}
