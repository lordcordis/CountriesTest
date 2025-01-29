//
//  MainCountriesView.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import SwiftUI

struct MainCountriesView: View {
    
    @StateObject var viewModel: MainCountriesViewModel
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.countriesFullList, id: \.name.common) { country in
                    MainCountriesCell(country: country)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)

        }
    }
    
    var searchResults: [Country] {
        if viewModel.searchEnabled {
            return viewModel.countriesFullList.filter { country in
                country.name.common.contains(viewModel.searchInput)
            }
        } else {
            return viewModel.countriesFullList
        }
    }
}

struct MainCountriesCell: View {
    
    let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var body: some View {
        GroupBox {
            
            HStack {
                Text(country.flag)
                    .font(.title)
                    .padding(.trailing)
                VStack(alignment: .leading) {
                    Text(country.name.common)
                    Text(country.continents.first?.rawValue ?? "")
                }
                Spacer()
            }
            
        }
    }
}

enum LocaleCell {
    case rus, unknown
}


