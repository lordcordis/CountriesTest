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
        }.overlay(content: {
            if viewModel.countries.isEmpty {
                ContentUnavailableView("No Favorite Countries", systemImage: "star.slash", description: Text("You haven't added any countries to your favorites yet."))
            }
        })
        .listStyle(.plain)
        .onAppear {
            viewModel.loadData()
        }
    }
}



