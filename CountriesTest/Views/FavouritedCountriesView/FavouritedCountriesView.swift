//
//  FavouritedCountriesView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI

struct FavouritedCountriesView: View {
    
    @StateObject var viewModel: FavouritedCountriesViewModel
    var coordinator: Coordinator?
    let localeData = LocaleManager.getLocale()
    
    var body: some View {
        List {
            ForEach(viewModel.countries, id: \.name) { country in
                MainCountriesCell(countryCacheable: country, localeCell: localeData)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.removeCountry(countryToDelete: country)
                        } label: {
                            Text("Delete")
                        }
                    }
                    .onTapGesture {
                        coordinator?.presentDetailedView(country: country, localizedName: country.nameLocalized, origin: .favourites)
                    }
                
                
                
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.loadData()
        }
        EmptyView().onAppear {
            print("onap")
        }
    }
}

final class FavouritedCountriesViewModel: ObservableObject {
    
    @Published var countries: [CountryCacheable] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        fetchCountriesFromCoreData()
    }
    
    func removeCountry(countryToDelete: CountryCacheable) {
        do {
            if let firstIndex = countries.firstIndex(where: { country in
                country.name == countryToDelete.name
            }) {
                do {
                    try CoreDataManager.shared.deleteCountry(countryName: countryToDelete.name)
                    countries.remove(at: firstIndex)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchCountriesFromCoreData() {
        do {
            if let countriesRetrieved = try CoreDataManager.shared.retrieveSavedCountries() {
                self.countries = countriesRetrieved
            } else {
                self.countries = []
            }
        } catch {
            self.countries = []
            print("Failed to load countries: \(error.localizedDescription)")
        }
    }
    
    
}

