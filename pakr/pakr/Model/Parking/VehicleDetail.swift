//
//  VehicleDetail.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class VehicleDetail: NSObject {
    
    let vehicleType: VehicleType!
    let minPrice: String!
    let maxPrice: String!
    let note: String!
    
    init(vehicleType: VehicleType!, minPrice: String!, maxPrice: String!, note: String!) {
        self.vehicleType = vehicleType
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.note = note
    }
}