//
//  JSONUtils.swift
//  pakr
//
//  Created by nguyen trung quang on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class ConfigJson: NSObject {

    class var getListParkingFromJson: [Parking] {
        let path = NSBundle.mainBundle().pathForResource("parkings", ofType: "json")
        let data = try! NSData(contentsOfURL: NSURL(fileURLWithPath: path!), options:NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonObj =  try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
        let arrParking = NSMutableArray()
        for dic in jsonObj{
            let parking = Parking(dic: dic as! NSDictionary)
            arrParking.addObject(parking)
        }
        return arrParking.copy() as! [Parking]
    }
}
