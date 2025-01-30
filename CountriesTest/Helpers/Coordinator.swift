//
//  Coordinator.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import UIKit
import SwiftUI

/// A class responsible for handling navigation and presenting views using UIKit.
class Coordinator {
    
    /// The currently active UIViewController used for presenting new views.
    var viewController: UIViewController?
    
    /// Sets the reference to the current view controller.
    /// - Parameter viewController: The view controller to be set.
    func setViewController(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    /// Presents the `CountryDetailedView` inside a `UIHostingController` as a modal sheet.
    /// - Parameters:
    ///   - country: The country data to display in the detailed view.
    ///   - localizedName: The localized name of the country (not used in this function but can be used for future localization improvements).
    ///   - origin: The origin of the detailed view, useful for navigation logic.
    func presentDetailedView(country: CountryCacheable, localizedName: String, origin: DetailedViewOrigin) {
        DispatchQueue.main.async {
            let hosting = UIHostingController(rootView: CountryDetailedView(countryCacheable: country, origin: origin, coordinator: self))
            hosting.modalPresentationStyle = .pageSheet
            self.viewController?.present(hosting, animated: true)
        }
    }
    
    /// Dismisses the last presented view controller.
    func dismissLast() {
        viewController?.dismiss(animated: true)
    }
    
    /// Presents the `UIActivityViewController` for sharing a file.
    /// - Parameter tempURL: The temporary URL of the file to be shared.
    func presentActivity(tempURL: URL) {
        // Dismiss any currently presented view before showing the activity view controller.
        dismissLast()
        
        let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
        
        self.viewController?.present(activityVC, animated: true)
    }
}

