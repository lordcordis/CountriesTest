//
//  ViewController.swift
//  CountriesTest
//
//  Created by Роман on 28.01.2025.
//

import UIKit

final class MainCountriesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray2
        
        Task {
            guard let countries: [Country]? = try? await NetworkManager.shared.fetchAllCountries() else {return}
            
            guard let filteredCountries: [Country] = countries else {return}
            
            for country in filteredCountries {
                print(country.name.common)
            }
        }
    }


}

