//
//  Parking.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/5/16.
//  Copyright © 2016 Pakr. All rights reserved.
//
// 2016

import UIKit

class Parking: NSObject {

    let dateCreated: NSDate!
    let parkingName: String!
    let addressName: String!
    let coordinate: Coordinate!
    var verify: Bool! = false
    var parkingType: ParkingType!
    var imageUrl: [String]?
    var openTime: NSDate?
    var telphoneNumber: String?
    var price: Double?
    var comments: [Comment]?

    init(parkingName: String!, dateCreated: NSDate!, addressName: String, latitude: Double, longitude: Double, parkingType: ParkingType!) {
        self.parkingName = parkingName
        self.dateCreated = dateCreated
        self.addressName = addressName
        self.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        self.parkingType = parkingType
    }
}
