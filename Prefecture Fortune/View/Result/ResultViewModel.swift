//
//  ResultViewModel.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/28.
//

import Foundation
import MapKit
import SwiftUI

@Observable
class ResultViewModel {
    
    let fortuneResult: FortuneResponse
    var cameraPosition: MapCameraPosition = MapCameraPosition.region(.tokyo)
    var capitalCoordinate: CLLocationCoordinate2D? = nil
    
    init(fortuneResult: FortuneResponse) {
        self.fortuneResult = fortuneResult
    }
    
    func searchLocation() async {
        do {
            let placemarks = try await CLGeocoder().geocodeAddressString(fortuneResult.name)
            if let location = placemarks.first?.location {
                let coordinate = location.coordinate
                self.cameraPosition = MapCameraPosition.region(
                    .init(
                        center: coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
                    )
                )
            } else {
                print("Location not found")
            }
        } catch {
            print("Location not found:", error as Any)
        }
    }
    
    func searchCapital() async {
        do {
            let placemarks = try await CLGeocoder().geocodeAddressString(fortuneResult.capital)
            if let location = placemarks.first?.location {
                let coordinate = location.coordinate
                self.capitalCoordinate = coordinate
            } else {
                self.capitalCoordinate = nil
                print("Location not found")
            }
        } catch {
            self.capitalCoordinate = nil
            print("Location not found:", error as Any)
        }
    }
}
