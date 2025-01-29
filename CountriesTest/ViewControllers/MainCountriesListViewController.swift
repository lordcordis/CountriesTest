//
//  ViewController.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import UIKit
import SwiftUI

final class MainCountriesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performInitialSetup()
    }
    
    
    func performInitialSetup() {
        let manager = NetworkManager()
        let viewModel = MainCountriesViewModel(networkManager: manager)
        let hosting = UIHostingController(rootView: MainCountriesView(viewModel: viewModel))
        showFullscreenHostingController(hosting: hosting)
    }
}



