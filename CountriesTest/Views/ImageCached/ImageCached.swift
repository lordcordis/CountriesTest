//
//  ImageCached.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI

// SwiftUI view to load and display an image from a URL with optional resizing
struct ImageCached: View {
    
    let urlString: String // URL string for the image
    let resizeable: Bool // Flag to determine if the image should be resizable
    @StateObject var viewModel = ImageCachedViewModel() // ViewModel to load and manage image
    
    // Initializer to set the URL string and resizeable flag
    init(urlString: String, resizeable: Bool) {
        self.resizeable = resizeable
        self.urlString = urlString
    }
    
    var body: some View {
        // If the image is resizeable, use resizable modifier
        if resizeable {
            Image(uiImage: viewModel.image)
                .resizable() // Make the image resizable
                .scaledToFit() // Scale the image to fit within its frame
                .onAppear {
                    viewModel.loadImage(urlString: urlString) // Load image on appear
                }
        } else {
            // Otherwise, display image with fixed size
            Image(uiImage: viewModel.image)
                .frame(width: 90, height: 120) // Fixed frame size
                .onAppear {
                    viewModel.loadImage(urlString: urlString) // Load image on appear
                }
                .scaledToFit() // Scale the image to fit within the frame
        }
    }
}
