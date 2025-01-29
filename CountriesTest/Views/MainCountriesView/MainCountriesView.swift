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
                ForEach(viewModel.countryCacheableList, id: \.name) { country in
                    MainCountriesCell(countryCacheable: country, localeCell: viewModel.localeCell)
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
    
    let country: CountryCacheableProtocol
    let localeCell: LocaleCell
    
    init(countryCacheable: CountryCacheableProtocol, localeCell: LocaleCell) {
        self.country = countryCacheable
        self.localeCell = localeCell
    }
    
    var body: some View {
        GroupBox {
            
            HStack {
                Text(country.flagEmoji)
                    .font(.title)
                    .padding(.trailing)
                VStack(alignment: .leading) {
                    switch localeCell {
                    case .rus:
                        Text(country.nameLocalized)
                    case .unknown:
                        Text(country.name)
                    }
                    
                    
                    Text(country.continents.description)
                }
                Spacer()
            }
            
        }
    }
}

enum LocaleCell {
    case rus, unknown
}


