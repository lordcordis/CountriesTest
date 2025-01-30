//
//  Coordinator.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import UIKit
import SwiftUI

class Coordinator {
    
    var viewController: UIViewController?
    
    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func presentDetailedView(country: CountryCacheable, localizedName: String) {

        DispatchQueue.main.async {
            let hosting = UIHostingController(rootView: CountryDetailedView(countryCacheable: country))
            hosting.modalPresentationStyle = .pageSheet
            self.viewController?.present(hosting, animated: true)
        }
    }
    
}
