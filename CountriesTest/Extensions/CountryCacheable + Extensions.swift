//
//  File.swift
//  CountriesTest
//
//  Created by Роман on 31.01.2025.
//

import PDFKit

extension CountryCacheable {
    // Function to generate a PDF containing country details
    func generatePDF() -> Data? {
        
        // Retrieve locale data to determine whether to use Russian or other language
        let localeData = LocaleManager.getLocale()
        
        // Set up PDF metadata such as creator and author
        let pdfMetaData = [
            kCGPDFContextCreator: "CountriesTest",
            kCGPDFContextAuthor: "Роман"
        ]
        
        // Create a PDF renderer format with metadata
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        // Define the page size (612x792 is typical for letter-sized PDF)
        let pageWidth: CGFloat = 612
        let pageHeight: CGFloat = 792
        
        // Initialize the PDF renderer with the page bounds and format
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), format: format)

        // Create the PDF data using the renderer
        let data = renderer.pdfData { context in
            // Start the page
            context.beginPage()
            
            // Set the title of the PDF based on the locale
            let title: String
            switch localeData {
            case .rus:
                title = "Информация о стране"  // Russian for "Country Info"
            case .otherThanRus:
                title = "Country info"
            }
            
            // Set attributes for the title (font size and weight)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 24)
            ]
            // Draw the title at the top of the page
            title.draw(at: CGPoint(x: 20, y: 20), withAttributes: attributes)
            
            // Initial Y offset for the country details text
            var yOffset: CGFloat = 60
            let lineSpacing: CGFloat = 25
            
            // Prepare the country details text depending on the locale
            let countryDetails: String
            switch localeData {
            case .rus:
                countryDetails = """
                Название: \(nameLocalized)
                Столица: \(capital)
                Валюта: \(currencyString)
                Часовые пояса: \(timeZones)
                Население: \(population)
                Площадь: \(area) км²
                Континенты: \(continents.joined(separator: ", "))
                Координаты: \(latitude), \(longitude)
                """
            case .otherThanRus:
                countryDetails = """
                            Name: \(name)
                            Capital: \(capital)
                            Currency: \(currencyString)
                            Time Zones: \(timeZones)
                            Population: \(population)
                            Area: \(area) km²
                            Continents: \(continents.joined(separator: ", "))
                            Coordinates: \(latitude), \(longitude)
                            """
            }
            
            // Set the attributes for the country details text (smaller font size)
            let detailsAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18)
            ]
            
            // Split the country details into lines and draw each line on the PDF
            for line in countryDetails.components(separatedBy: "\n") {
                line.draw(at: CGPoint(x: 20, y: yOffset), withAttributes: detailsAttributes)
                yOffset += lineSpacing  // Move the Y offset down after each line
            }
        }
        
        // Return the generated PDF data
        return data
    }
}
