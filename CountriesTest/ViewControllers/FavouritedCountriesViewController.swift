//
//  FavouritedCountriesViewController.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import UIKit
import SwiftUI

final class FavouritedCountriesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performInitialSetup()

    }
    
    func performInitialSetup() {
        
        let coordinator = Coordinator()
        coordinator.setViewController(viewController: self)
        
        let viewModel = FavouritedCountriesViewModel()
        let hosting = UIHostingController(rootView: FavouritedCountriesView(viewModel: viewModel, coordinator: coordinator))
        showFullscreenHostingController(hosting: hosting)
    }
}
