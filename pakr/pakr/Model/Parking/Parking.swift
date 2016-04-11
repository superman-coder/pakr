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

    let business: Business!
    let dateCreated: NSDate!
    let parkingName: String!
    let capacity: Int!
    let addressName: String!
    let coordinate: Coordinate!
    var verify: Bool! = false
    var vehicleList: [VehicleDetail]!
    var region: [String]!
    var imageUrl: [String]?
    var schedule: [TimeRange]!

    init(business: Business!, parkingName: String!, capacity: Int!, dateCreated: NSDate!, addressName: String, coordinate: Coordinate!, vehicleDetailList: [VehicleDetail]!, schedule: [TimeRange]!, region: [String]!) {
        self.business = business
        self.parkingName = parkingName
        self.capacity = capacity
        self.dateCreated = dateCreated
        self.addressName = addressName
        self.coordinate = coordinate
        self.vehicleList = vehicleDetailList
        self.schedule = schedule
        self.region = region
    }
}
