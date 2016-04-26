//
//  ParkAnnotation.swift
//  pakr
//
//  Created by Tien on 4/10/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MapKit

class ParkAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let tag: Int!
    
    init(title:String?, subtitle:String?, coordinate:CLLocationCoordinate2D!, tag:Int!) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.tag = tag
    }
    
    
    
}
