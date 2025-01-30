//
//  CountryCacheable.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import Foundation

struct CountryCacheable: CountryInfoCellProtocol, CountryDetailedViewProtocol {
    
    init?(cacheableEntity: CountryCacheableEntity) {
        
        guard let name = cacheableEntity.name,
              let nameLocalized = cacheableEntity.nameLocalized,
              let currencyString = cacheableEntity.currencyString,
              let timeZones: String = cacheableEntity.timeZones,
              let capital = cacheableEntity.capital,
              let flagEmoji: String = cacheableEntity.flagEmoji,
                let flagPng: String = cacheableEntity.flagPng,
              let continents: [String] = cacheableEntity.continents?.components(separatedBy: ",") else
        { return nil }
        
        self.name = name
        self.nameLocalized = nameLocalized
        self.currencyString = currencyString
        self.timeZones = timeZones
        self.capital = capital
        self.flagPng = flagPng
        self.flagEmoji = flagEmoji
        self.area = cacheableEntity.area
        self.latitude = cacheableEntity.latitude
        self.longitude = cacheableEntity.longitude
        self.population = Int(cacheableEntity.population)
        self.continents = continents
    }
    
    init?(countryFullNetworkResult: CountryFullNetworkResult, localizedName: String) {
        
        self.name = countryFullNetworkResult.name.official
        self.nameLocalized = localizedName
        self.currencyString = countryFullNetworkResult.currencies
            .map { _, currency in
                return "\(currency.name): \(currency.symbol)"
            }
            .joined(separator: ", ")
        
        self.timeZones = countryFullNetworkResult.timezones.map { $0
        }.joined(separator: ", ")
        
        guard let capital = countryFullNetworkResult.capital.first else {
            return nil
        }
        
        self.capital = capital
        self.population = countryFullNetworkResult.population
        self.area = countryFullNetworkResult.area
        self.flagEmoji = countryFullNetworkResult.flag
        self.flagPng = countryFullNetworkResult.flags.png
        self.continents = countryFullNetworkResult.continents.map({ continent in
            continent.rawValue
        })
        
        guard let latitude = countryFullNetworkResult.latlng.first, let longitude =  countryFullNetworkResult.latlng.last else {
            return nil
        }

        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    let name: String
    let nameLocalized: String
    let currencyString: String
    let timeZones: String
    let capital: String
    let population: Int
    let area: Double
    let latitude: Double
    let longitude: Double
    let flagEmoji: String
    let flagPng: String
    let continents: [String]
}

import UIKit
import PDFKit

extension CountryCacheable {
    func generatePDF() -> Data? {
        let pdfMetaData = [
            kCGPDFContextCreator: "CountriesTest",
            kCGPDFContextAuthor: "Роман"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageWidth: CGFloat = 612
        let pageHeight: CGFloat = 792
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), format: format)

        let data = renderer.pdfData { context in
            context.beginPage()
            
            let title = "Информация о стране"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 24)
            ]
            title.draw(at: CGPoint(x: 20, y: 20), withAttributes: attributes)
            
            var yOffset: CGFloat = 60
            let lineSpacing: CGFloat = 25
            
            let countryDetails = """
            Название: \(name)
            Локализованное название: \(nameLocalized)
            Столица: \(capital)
            Валюта: \(currencyString)
            Часовые пояса: \(timeZones)
            Население: \(population)
            Площадь: \(area) км²
            Континенты: \(continents.joined(separator: ", "))
            Координаты: \(latitude), \(longitude)
            """
            
            let detailsAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18)
            ]
            
            for line in countryDetails.components(separatedBy: "\n") {
                line.draw(at: CGPoint(x: 20, y: yOffset), withAttributes: detailsAttributes)
                yOffset += lineSpacing
            }
        }
        
        return data
    }
}
