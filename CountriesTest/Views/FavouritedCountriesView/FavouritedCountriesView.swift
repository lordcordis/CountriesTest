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
            }
        }
        .listStyle(.plain)
        .onAppear {
            viewModel.loadData()
        }
    }
}

class FavouritedCountriesViewModel: ObservableObject {
    
    init() {
        
        do {
            let countriesRetrieved = try CoreDataManager.shared.retrieveSavedCountries()
            if let countries = countriesRetrieved {
                self.countries = countries
            } else {
                self.countries = [CountryCacheable]()
            }
        } catch {
            self.countries = [CountryCacheable]()
            print(error.localizedDescription)
        }
        
        
    }
    
    func loadData() {
        do {
            let countriesRetrieved = try CoreDataManager.shared.retrieveSavedCountries()
            if let countries = countriesRetrieved {
                self.countries = countries
            } else {
                self.countries = [CountryCacheable]()
            }
        } catch {
            self.countries = [CountryCacheable]()
            print(error.localizedDescription)
        }
    }
    
    @Published var countries: [CountryCacheable]
}
