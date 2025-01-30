//
//  UIViewController+Extensions.swift
//  CountriesTest
//
//  Created by Роман on 29.01.2025.
//

import UIKit
import SwiftUI

/// An extension for `UIViewController` that provides a method to embed a `UIHostingController`
/// inside the current view while respecting the safe area.
extension UIViewController {
    
    /// Adds a `UIHostingController`'s view as a subview within the safe area of the current view.
    /// - Parameter hosting: A `UIHostingController` containing a SwiftUI view.
    func showFullscreenHostingController(hosting: UIHostingController<some View>) {
        // Add the hosting controller as a child view controller
        addChild(hosting)
        
        // Disable autoresizing masks to use Auto Layout
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the hosting controller's view as a subview
        view.addSubview(hosting.view)
        
        // Notify the hosting controller that it has been moved to a parent
        hosting.didMove(toParent: self)
        
        // Apply constraints to make the hosting view fill the safe area
        NSLayoutConstraint.activate([
            hosting.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            hosting.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
