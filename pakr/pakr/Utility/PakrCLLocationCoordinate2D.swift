//
//  PakrCLLocationCoordinate2D.swift
//  pakr
//
//  Created by Tien on 4/10/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

extension CLLocationCoordinate2D {
    func CLLocationPoint() -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}