//
//  FavouritedCountriesViewController.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import UIKit
import SwiftUI

// ViewController for displaying favorited countries
final class FavouritedCountriesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performInitialSetup() // Set up the view controller and view model
    }
    
    // Set up the coordinator and view model for the view
    func performInitialSetup() {
        let coordinator = Coordinator()
        coordinator.setViewController(viewController: self)
        
        let viewModel = FavouritedCountriesViewModel()
        let hosting = UIHostingController(rootView: FavouritedCountriesView(viewModel: viewModel, coordinator: coordinator))
        showFullscreenHostingController(hosting: hosting) // Display the view
    }
}
