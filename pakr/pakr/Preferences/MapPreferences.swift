//
//  PakrPreferences.swift
//  pakr
//
//  Created by Tien on 4/10/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MapKit

let kLastLocation = "last_location"
let kLastLocationLatitude = "last_location_latitude"
let kLastLocationLongitude = "last_location_latitude"

extension NSUserDefaults {
    func getLastSavedLocation() -> CLLocationCoordinate2D? {
        let validStoredLocation = self.objectForKey(kLastLocation)
        
        var storedLocation:CLLocationCoordinate2D?
        if validStoredLocation == nil {
            // No stored location
            storedLocation = CLLocationCoordinate2D(latitude:10.766650, longitude:106.707269)
        } else {
            let latitude = self.doubleForKey(kLastLocationLatitude)
            let longitude = self.doubleForKey(kLastLocationLongitude)
            storedLocation = CLLocationCoordinate2DMake(latitude, longitude)
        }
        return storedLocation
    }
    
    func saveLastLocation(location: CLLocationCoordinate2D) {
        self.setDouble(location.latitude, forKey: kLastLocationLatitude)
        self.setDouble(location.longitude, forKey: kLastLocationLongitude)
        self.setObject("not_nil", forKey: kLastLocation)
        self.synchronize()
    }
}
