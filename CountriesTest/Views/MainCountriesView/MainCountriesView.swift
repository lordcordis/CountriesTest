//
//  MainCountriesView.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import SwiftUI

struct MainCountriesView: View {
    
    // ViewModel and network monitor
    @StateObject var viewModel: MainCountriesViewModel
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        NavigationStack {
            // Check if the network is connected
            if networkMonitor.isConnected {
                countriesListView
                    .overlay {
                        // Show loading indicator or offline mode view
                        if viewModel.loadingIndicator == .loading {
                            LoadingIndicatorView()
                        }
                        
                        if viewModel.forcedOfflineMode {
                            forcedOfflineModeView
                        }
                    }
            } else {
                NoInternetView() // No internet connection view
            }
        }
    }
    
    // List view for countries
    var countriesListView: some View {
        List {
            // Filter countries based on search input
            let countries = viewModel.searchEnabled ? viewModel.countryListFilterable : viewModel.countryListFull
            
            ForEach(countries, id: \.name) { country in
                MainCountriesCell(countryCacheable: country, localeCell: viewModel.localeCell)
                    .onTapGesture {
                        viewModel.countryCellTapped(country: country) // Handle tap on country cell
                    }
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchInput, isPresented: $viewModel.searchEnabled) // Search functionality
        .onChange(of: viewModel.searchInput) { oldValue, newValue in
            viewModel.filterCountries() // Filter countries on search input change
        }
        .alert(viewModel.alertText, isPresented: $viewModel.alertIsActive) {
            // Alert with retry and offline mode options
            Button("Retry loading data") {
                viewModel.retryLoadingDataButtonPressed()
            }
            Button("Continue in offline mode") {
                viewModel.loadingIndicator = .notLoading
                viewModel.forcedOfflineMode = true
            }
        }
    }
    
    // Offline mode view
    var forcedOfflineModeView: some View {
        GroupBox {
            ContentUnavailableView("App is Offline", // Title of the view
                                   systemImage: "exclamationmark.triangle", // Icon for the view
                                   description: Text("The app is currently offline. Please try again later.")) // Description
            Button("Retry loading data") {
                viewModel.retryLoadingDataButtonPressed() // Retry loading data
                viewModel.forcedOfflineMode = false
            }
        }.padding()
    }
}
