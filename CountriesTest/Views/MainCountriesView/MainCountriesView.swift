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
            .onAppear {
                print("onappear")
            }
            .overlay(content: {
                if !networkMonitor.isConnected {
                    
                    
                    ZStack {
                        Color.clear
                            .edgesIgnoringSafeArea(.all)
                            .background(Material.thin)
                        NoInternetView()
                    }
                }
            })
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
}





