//
//  File.swift
//  AiportFinder
//
//  Created by Eduardo Batista on 05/05/24.
//

import Foundation
import MapKit

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        DispatchQueue.main.async { [weak self] in
            self?.setRegion(coordinateRegion, animated: true)
        }
    }
}

