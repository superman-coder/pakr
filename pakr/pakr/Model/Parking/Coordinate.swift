//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

@objc class Coordinate: NSObject {
    let latitude: Double!
    let longitude: Double!

    init(latitude: Double!, longitude: Double!) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init(pfObject: PFGeoPoint) {
        self.latitude = pfObject.latitude
        self.longitude = pfObject.longitude
    }
    
    func toGeoPointObject() -> PFGeoPoint {
        return PFGeoPoint(latitude: latitude, longitude: longitude)
    }
}
