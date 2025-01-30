//
//  NoInternetView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI

// View displayed when there is no internet connection
struct NoInternetView: View {
    var body: some View {
        ContentUnavailableView("No Internet Connection", // Title of the view
                               systemImage: "wifi.exclamationmark", // Icon for the view
                               description: Text("Check your network connection and try again.")) // Description
    }
}
