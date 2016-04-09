//
//  Parking.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/5/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class Parking: NSObject {

    let parkingId: String!
    let dateCreated: NSDate!
    let user: User!
    let addressName: String!
    let coordinate: Coordinate!
    var verify: Bool! = false
    var parkingType: ParkingType!
    var imageUrl: [String]?
    var openTime: NSDate?
    var telphoneNumber: String?
    var price: Double?
    var comments: [Comment]?

    init(parkingId: String!, dateCreated: NSDate!, user: User!, addressName: String, latitude: Double, longitude: Double, parkingType: ParkingType!) {
        self.parkingId = parkingId
        self.user = user
        self.dateCreated = dateCreated
        self.addressName = addressName
        self.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        self.parkingType = parkingType
    }
}
