//
//  NetworkError.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import Foundation
import SwiftUICore

enum NetworkError: Error {
    case missingKey, badURL, badData, badResponse, dataCantBeDecoded, listIsEmpty
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingKey:
            return LocalizedStringKey("missingKey").toString()
        case .badURL:
            return LocalizedStringKey("badURL").toString()
        case .badData:
            return LocalizedStringKey("badData").toString()
        case .badResponse:
            return LocalizedStringKey("badResponse").toString()
        case .dataCantBeDecoded:
            return LocalizedStringKey("dataCantBeDecoded").toString()
        case .listIsEmpty:
            return LocalizedStringKey("listIsEmpty").toString()
        }
    }
}

extension LocalizedStringKey {
    func toString() -> String {
        let mirror = Mirror(reflecting: self)
        if let string = mirror.children.first(where: { $0.label == "key" })?.value as? String {
            return string
        }
        return ""
    }
}
