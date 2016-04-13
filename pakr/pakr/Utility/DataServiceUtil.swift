//
//  LocationUtil.swift
//  pakr
//
//  Created by Tien on 4/10/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MapKit

class DataServiceUtil: NSObject {
    // Reload when distance from current center to last data center > 2/3 * old radius.
    // or zooming out
    class func needToReloadParking(dataCenterPoint:CLLocationCoordinate2D?, newLocation:CLLocationCoordinate2D?, lastDataLoadingRadius:Double, newMapViewRadius:Double) -> Bool {
        
        if dataCenterPoint == nil {
            return true
        }
        
        if newLocation == nil {
            return false
        }
        
        let newLocation = newLocation!
        let lastLocation = dataCenterPoint!
        if !CLLocationCoordinate2DIsValid(newLocation) || !(CLLocationCoordinate2DIsValid(lastLocation)) {
            return false
        }
        
        if newMapViewRadius > (lastDataLoadingRadius) {
            return true
        }
        
        let lastCLLocation = lastLocation.CLLocationPoint()
        let newCLLocation = newLocation.CLLocationPoint()
        let distance = newCLLocation.distanceFromLocation(lastCLLocation)
        print("Distance from \(lastLocation) to \(newLocation) is \(distance)")
        return distance > (lastDataLoadingRadius * 2/3);
    }
}
