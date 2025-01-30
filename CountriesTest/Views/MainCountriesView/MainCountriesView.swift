//
//  MainCountriesView.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import SwiftUI

struct MainCountriesView: View {
    
    @StateObject var viewModel: MainCountriesViewModel
    @StateObject var networkMonitor = NetworkMonitor()
    
    
    var body: some View {
        NavigationStack {
            
            if networkMonitor.isConnected {
                countriesListView
                    .overlay {
                        if viewModel.loadingIndicator == .loading {
                            LoadingIndicatorView()
                        }
                    }
            } else {
                NoInternetView()
            }
        }
    }
    
    var countriesListView: some View {
        List {

            let countries = viewModel.searchEnabled ? viewModel.countryCacheableList : viewModel.countryCacheableListBackup
            
            ForEach(countries, id: \.name) { country in
                MainCountriesCell(countryCacheable: country, localeCell: viewModel.localeCell)
                    .onTapGesture {
                        viewModel.countryCellTapped(country: country)
                    }
                    .listRowSeparator(.hidden)
            }
        }
        .onAppear {
            print("onappear")
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
            Button("Continue in offline mode") {
                
            }
        }
    }
}






