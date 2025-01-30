//
//  NetworkMonitor.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
import Network

/// Monitors the network connection status and updates the app accordingly.
class NetworkMonitor: ObservableObject {
    
    // Network path monitor to check connection status
    private let monitor = NWPathMonitor()
    
    // Background queue to run the monitor
    private let queue = DispatchQueue.global(qos: .background)
    
    // Published property that reflects the network connection status
    @Published var isConnected: Bool = true
    
    /// Initializes the network monitor and sets the path update handler.
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                // Update the connection status based on path status
                self?.isConnected = path.status == .satisfied
            }
        }
        
        // Start monitoring the network path
        monitor.start(queue: queue)
    }
}
