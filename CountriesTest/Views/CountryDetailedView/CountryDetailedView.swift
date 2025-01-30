//
//  CountryDetailedView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct CountryDetailedView: View {
    
    init(countryCacheable: CountryCacheable, origin: DetailedViewOrigin, coordinator: Coordinator?) {
        self.localeData = LocaleManager.getLocale()
        self.countryCacheable = countryCacheable
        self.name = countryCacheable.name
        self.nameLocalized = countryCacheable.nameLocalized
        self.currencyString = countryCacheable.currencyString
        self.timeZones = countryCacheable.timeZones
        self.capital = countryCacheable.capital
        self.area = countryCacheable.area
        self.population = countryCacheable.population
        self.continents = countryCacheable.continents
        self.flagPng = countryCacheable.flagPng
        self.latitude = countryCacheable.latitude
        self.longitude = countryCacheable.longitude
        self.origin = origin
        self.coordinator = coordinator
        
        do {
            let isSaved = try CoreDataManager.shared.containsCountry(countryName: countryCacheable.name)
            self.countrySavedInFavourites = isSaved
            print("countrySavedInFavourites \(countrySavedInFavourites)")
        } catch {
            self.countrySavedInFavourites = false
            showAlert(text: error.localizedDescription)
        }
    }
    
    private func showAlert(text: String) {
        self.alertText = text
        self.showAlert.toggle()
    }
    
    private func sharePDF(country: CountryCacheable) {
        guard let pdfData = country.generatePDF() else { return }
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(country.name).pdf")
        try? pdfData.write(to: tempURL)
        coordinator?.presentActivity(tempURL: tempURL)
    }
    
    let countryCacheable: CountryCacheable
    
    let localeData: LocaleData
    
    var coordinator: Coordinator?
    
    let name: String
    let nameLocalized: String
    let currencyString: String
    let timeZones: String
    let capital: String
    let population: Int
    let area: Double
    let latitude: Double
    let longitude: Double
    let flagPng: String
    let continents: [String]
    let origin: DetailedViewOrigin
    
    @State var countrySavedInFavourites: Bool
    @State var showAlert = false
    @State var alertText = ""
    
    func favouriteToggleChanged() {
        
        switch countrySavedInFavourites {
            
        case true:
            do {
                try CoreDataManager.shared.saveCountry(country: countryCacheable)
            } catch {
                showAlert(text: error.localizedDescription)
            }
        case false:
            do {
                try CoreDataManager.shared.deleteCountry(countryName: countryCacheable.name)
            } catch {
                showAlert(text: error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            headerView
            
            Divider()
            
            countryDetailedInfoView
            
            MapView(latitude: latitude, longitude: longitude)
            
            flagFullView
            
            Spacer()
        }
        .alert(alertText, isPresented: $showAlert) {
            
        }
    }
    
    var sharePDFButton: some View {
        Button {
            sharePDF(country: countryCacheable)
        } label: {
            Image(systemName: "square.and.arrow.up")
                .padding(.trailing)
        }
    }
    
    var favouriteToggle: some View {
        Toggle(isOn: $countrySavedInFavourites, label: {
            Image(systemName: countrySavedInFavourites ? "star.fill" : "star")
                .tint(Color("yellowCustom"))
                .font(.title3)
        })
        .toggleStyle(.button)
        .tint(.clear)
        .onChange(of: countrySavedInFavourites, {
            favouriteToggleChanged()
        })
    }
    
    var countryDetailedInfoView: some View {
        VStack(alignment: .leading) {
            Text("Capital: \(capital)")
            Text("Population: \(population)")
            Text("Area: \(area)")
            Text("Currency: \(currencyString)")
            Text("Timezones: \(timeZones)")
        }.padding()
    }
    
    var flagFullView: some View {
        ImageCached(urlString: flagPng, resizeable: true)
            .frame(height: 150)
            .padding()
    }
    
    var headerView: some View {
        HStack {
            switch localeData {
            case .rus:
                Text(nameLocalized)
                    .font(.headline)
                    .padding()
            case .otherThanRus:
                Text(name)
                    .font(.headline)
                    .padding()
            }
            
            Spacer()
            
            sharePDFButton
            
            if origin == .fullList {
                favouriteToggle
            }
        }
    }
}


