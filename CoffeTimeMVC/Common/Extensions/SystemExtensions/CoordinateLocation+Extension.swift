//
//  CoordinateLocation+Extension.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 02.10.2023.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
