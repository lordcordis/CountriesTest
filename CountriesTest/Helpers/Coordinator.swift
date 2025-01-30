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
    
    func presentDetailedView(country: CountryCacheable, localizedName: String, origin: DetailedViewOrigin) {

        DispatchQueue.main.async {
            let hosting = UIHostingController(rootView: CountryDetailedView(countryCacheable: country, origin: origin, coordinator: self))
            hosting.modalPresentationStyle = .pageSheet
            self.viewController?.present(hosting, animated: true)
        }
    }
    
    func dismissLast() {
        viewController?.dismiss(animated: true)
    }
    
    func presentActivity(tempURL: URL) {
        dismissLast()
        
        let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first?.rootViewController {
            window.present(activityVC, animated: true)
        }
    }
    
}
