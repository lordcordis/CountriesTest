//
//  MapView.swift
//  CountriesTest
//
//  Created by Роман on 30.01.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    // Parameters for latitude and longitude
    var latitude: Double
    var longitude: Double
    
    // State to manage the map region
    @State private var region: MKCoordinateRegion
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        // Initial region based on the provided coordinates
//        _region = State(initialValue: MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
//            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05),
//            
//        ))
        _region = State(initialValue: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                    span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10) // Increased span
                ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
            .scrollDisabled(true)
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
            .padding()
    }
}
