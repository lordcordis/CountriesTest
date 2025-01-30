//
//  LocaleManager.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import Foundation

/// Manages locale settings for the application.
struct LocaleManager {
    
    /// Determines the current locale of the user and returns the corresponding `LocaleData` value.
    ///
    /// - Returns: `.rus` if the locale is Russian (`ru_RU`), otherwise returns `.otherThanRus`.
    static func getLocale() -> LocaleData {
        if Locale.current.identifier == "ru_RU" {
            return .rus
        } else {
            return .otherThanRus
        }
    }
}
