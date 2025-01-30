//
//  ImageCached.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
struct ImageCached: View {
    
    let urlString: String
    let resizeable: Bool
    @StateObject var viewModel = ImageCachedViewModel()
    
    init(urlString: String, resizeable: Bool) {
        self.resizeable = resizeable
        self.urlString = urlString
    }
    
    var body: some View {
        
        if resizeable {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFit()
                .onAppear {
                    viewModel.loadImage(urlString: urlString)
                }
            
        } else {
            Image(uiImage: viewModel.image)
                .frame(width: 90, height: 120)
                .onAppear {
                    viewModel.loadImage(urlString: urlString)
                }
                .scaledToFit()
        }
        
            
    }
}
