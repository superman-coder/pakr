//
//  GMGeocodeServices.swift
//  pakr
//
//  Created by Tien on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import Alamofire

let GM_API_KEY = "AIzaSyBihgw_0XW2AFbcrYgG98IV5XqlaIM3lfo"
let GM_REVERSE_GEOCODE_API = "https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&key=%@"

class GMGeocodeServices: NSObject {

    class func reverseGeocodeRequest(latitude:Double, longitude:Double, completion:(success:Bool, address:String?)->()) {
        let apiUrl = String(format: GM_REVERSE_GEOCODE_API, latitude, longitude, GM_API_KEY)
        Alamofire.request(.POST, apiUrl).responseJSON { response in
            let result = response.result
            var success:Bool = false
            var address:String? = nil
            if let _ = result.error {
                success = false
                address = nil
            } else {
                let gmResult = result.value as! NSDictionary
                let status = gmResult["status"] as! String
                
                if "OK" == status {
                    success = true
                    let addresses = gmResult["results"] as! [NSDictionary]
                    let firstResult = addresses[0]
                    let formattedAddress = firstResult["formatted_address"] as! String
                    address = formattedAddress
                } else if "ZERO_RESULTS" == status {
                    success = true
                    address = "No result"
                } else {
                    success = false
                    address = nil
                }
            }
            completion(success: success, address: address)
        }
    }
    
}
