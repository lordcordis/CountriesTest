//
//  MapView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
import MapKit

// A SwiftUI view displaying a map with a given latitude and longitude
struct MapView: View {
    var latitude: Double // Latitude of the location
    var longitude: Double // Longitude of the location
    
    @State private var region: MKCoordinateRegion // State to manage map region
    
    // Initializer to set latitude, longitude, and region
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        // Initial region based on provided coordinates with an increased span
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10) // Increased span
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region) // Map view using region
            .scrollDisabled(true) // Disable scrolling
            .frame(height: 300) // Set frame height
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))) // Rounded corners
            .padding() // Add padding around the map
    }
}
