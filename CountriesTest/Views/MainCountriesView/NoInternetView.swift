//
//  NoInternetView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct NoInternetView: View {
    var body: some View {
        ContentUnavailableView("No Internet Connection",
                               systemImage: "wifi.exclamationmark",
                               description: Text("Check your network connection and try again."))
    }
}
