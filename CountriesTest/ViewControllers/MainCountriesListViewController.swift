//
//  ViewController.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import UIKit
import SwiftUI

// ViewController for displaying the main countries list
final class MainCountriesListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performInitialSetup() // Set up the view controller and view model
    }
    
    // Set up the network manager, coordinator, and view model for the view
    func performInitialSetup() {
        let manager = NetworkManager()
        
        let coordinator = Coordinator()
        coordinator.setViewController(viewController: self)
        
        let viewModel = MainCountriesViewModel(networkManager: manager, coordinator: coordinator)
        let hosting = UIHostingController(rootView: MainCountriesView(viewModel: viewModel))
        showFullscreenHostingController(hosting: hosting) // Display the view
    }
}
