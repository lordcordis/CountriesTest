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
            print(error.localizedDescription)
        }
        
    }
    
    func saveCountryInFavourites() {
        do {
            try CoreDataManager.shared.saveCountry(country: countryCacheable)
            self.countrySavedInFavourites = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCountryFromFavourites() {
        do {
            try CoreDataManager.shared.deleteCountry(countryName: countryCacheable.name)
            self.countrySavedInFavourites = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func sharePDF(country: CountryCacheable) {
            guard let pdfData = country.generatePDF() else { return }
            let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(country.name).pdf")
            try? pdfData.write(to: tempURL)
        coordinator?.presentActivity(tempURL: tempURL)
        }
    
    let countryCacheable: CountryCacheable
    
    let localeData: LocaleData
    
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
    var coordinator: Coordinator?
    
    @State var countrySavedInFavourites: Bool
    
    func favouriteToggleChanged() {
        
        print(countrySavedInFavourites)
        
        switch countrySavedInFavourites {
            
        case true:
            do {
                try CoreDataManager.shared.saveCountry(country: countryCacheable)
            } catch {
                print(error.localizedDescription)
            }
        case false:
            do {
                try CoreDataManager.shared.deleteCountry(countryName: countryCacheable.name)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        do {
            let countries = try CoreDataManager.shared.retrieveSavedCountries()
            print(countries?.description)
        } catch {
            print(error.localizedDescription)
        }
        
        print(countrySavedInFavourites)
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            HStack {
                switch localeData {
                case .rus:
                    Text("\(nameLocalized)")
                        .font(.headline)
                        .padding()
                case .unknown:
                    Text("\(name)")
                        .font(.headline)
                        .padding()
                }
                
                Spacer()
                
                Button {
                    sharePDF(country: countryCacheable)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .padding(.trailing)
                }

                
                if origin == .fullList {
                    Toggle(isOn: $countrySavedInFavourites, label: {
                        Image(systemName: countrySavedInFavourites ? "star.fill" : "star")
                            .tint(.yellow)
                            .font(.title3)
                    })
                    .toggleStyle(.button)
                    .tint(.clear)
                    .onChange(of: countrySavedInFavourites, {
                        favouriteToggleChanged()
                    })

                }
                
            }
            
            
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Capital: \(capital)")
                Text("Population: \(population)")
                Text("Area: \(area)")
                Text("Currency: \(currencyString)")
                Text("Timezones: \(timeZones)")
            }.padding()
            
            MapView(latitude: latitude, longitude: longitude)
            ImageCached(urlString: flagPng, resizeable: true)
                .frame(height: 150)
                .padding()
            
            Spacer()
        }
        
        
    }
}

enum DetailedViewOrigin {
    case fullList, favourites
}
