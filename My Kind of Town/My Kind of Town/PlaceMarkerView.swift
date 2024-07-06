//
//  PlaceMarkerView.swift
//  My Kind of Town
//
//  Created by Yutong Sun on 2/5/24.
//

import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            clusteringIdentifier = "Place"
            displayPriority = .defaultLow
            markerTintColor = .systemRed
            glyphImage = UIImage(systemName: "pin.fill")
        }
    }
}
