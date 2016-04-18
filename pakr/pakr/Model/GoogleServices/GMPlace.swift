//
//  GMPlace.swift
//  pakr
//
//  Created by Tien on 4/18/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class GMPlace: NSObject {
    let geometry:Coordinate!
    let name:String!
    let address:String!
    
    init(json:NSDictionary) {
        let geometryJson = json["geometry"] as! NSDictionary
        let location = geometryJson["location"] as! NSDictionary
        let lat = location["lat"] as! Double
        let lng = location["lng"] as! Double
        
        geometry = Coordinate(latitude: lat, longitude: lng)
        name = json["name"] as! String
        address = json["formatted_address"] as! String
    }
}
