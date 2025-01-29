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
                if viewModel.searchEnabled {
                    ForEach(viewModel.countryCacheableList, id: \.name) { country in
                        MainCountriesCell(countryCacheable: country, localeCell: viewModel.localeCell)
                            .onTapGesture {
                                viewModel.countryCellTapped(country: country)
                            }
                            .listRowSeparator(.hidden)
                    }
                } else {
                    ForEach(viewModel.countryCacheableListBackup, id: \.name) { country in
                        MainCountriesCell(countryCacheable: country, localeCell: viewModel.localeCell)
                            .onTapGesture {
                                viewModel.countryCellTapped(country: country)
                            }
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchInput, isPresented: $viewModel.searchEnabled)
            .onChange(of: viewModel.searchInput) { oldValue, newValue in
                viewModel.filterCountries()
            }
            .alert(viewModel.alertText, isPresented: $viewModel.alertIsActive) {
                Button("Retry loading data") {
                    viewModel.retryLoadingDataButtonPressed()
                }
            }
        }
    }
}

struct MainCountriesCell: View {
    
    let country: CountryInfoCellProtocol
    let localeCell: LocaleData
    
    init(countryCacheable: CountryInfoCellProtocol, localeCell: LocaleData) {
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

enum LocaleData {
    case rus, unknown
}


