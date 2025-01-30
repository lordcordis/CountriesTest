//
//  Continent + Extension.swift
//  CountriesTest
//
//  Created by Роман on 31.01.2025.
//

// MARK: - Continent extension
// Extension for Continent to return Russian text for each continent
extension Continent {
    func russianText() -> String {
        switch self {
        case .africa: return "Африка"
        case .antarctica: return "Антарктида"
        case .asia: return "Азия"
        case .europe: return "Европа"
        case .northAmerica: return "Северная Америка"
        case .oceania: return "Океания"
        case .southAmerica: return "Южная Америка"
        }
    }
}
