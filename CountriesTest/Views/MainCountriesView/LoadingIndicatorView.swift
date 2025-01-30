//
//  LoadingIndicatorView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
// View to display a circular loading indicator
struct LoadingIndicatorView: View {
    var body: some View {
        GroupBox {
            ProgressView() // Display circular progress indicator
                .progressViewStyle(.circular) // Style as circular
                .padding() // Add padding around the indicator
        }
    }
}
