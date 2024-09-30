//
//  MKCoordinateRegion + Extension.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/28.
//

import MapKit

extension MKCoordinateRegion {
    static let tokyo = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.682839, longitude: 139.759455),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
}
