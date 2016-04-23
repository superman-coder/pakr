//
//  VehicleDetail.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class VehicleDetail: NSObject, ParseNestedObjectProtocol {
    
    let PKVehicleType = "vehicle_type"
    let PKVehiclePriceMin = "vehicle_price_min"
    let PKVehiclePriceMax = "vehicle_price_max"
    let PKVehicleNote = "vehicle_note"
    
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
    
    required init(dict: NSDictionary) {
        vehicleType = VehicleType(rawValue: dict[PKVehicleType] as! Int)
        minPrice = dict[PKVehiclePriceMin] as! String
        maxPrice = dict[PKVehiclePriceMax] as! String
        note = dict[PKVehicleNote] as! String
    }
    
    func toDictionary() -> NSDictionary {
        var dict: [String:AnyObject] = [:]
        dict[PKVehicleType] = vehicleType.rawValue
        dict[PKVehiclePriceMin] = minPrice
        dict[PKVehiclePriceMax] = maxPrice
        dict[PKVehicleNote] = note
        
        return dict
    }
}