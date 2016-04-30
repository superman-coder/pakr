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
let GM_SERVER_API_KEY = "AIzaSyBlV0OEJafgSSwFS96u-zpkBdQ4MbZqTwA"
let GM_REVERSE_GEOCODE_API = "https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&key=%@"
let GM_PLACES_API = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&key=%@&language=vn"

class GMServices: NSObject {

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
    
    class func requestAddressSearchWithAddress(address:String, completion:(success:Bool, location:[GMPlace]?)->()) {
        // Encode the address
        let components = address.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let nonspaceAddress = components.joinWithSeparator("+")
        let encodedAddress = nonspaceAddress.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        // Create request
        let apiUrl = String(format: GM_PLACES_API, encodedAddress, GM_SERVER_API_KEY)
        Alamofire.request(.POST, apiUrl).responseJSON { response in
            var success = false
            var locations:[GMPlace]? = nil
            
            let requestResult = response.result
            
            if let _ = requestResult.error {
                success = false
            } else {
                let gmResponse = requestResult.value as! NSDictionary
                let status = gmResponse["status"] as! String
                
                if "OK" == status {
                    success = true
                    locations = []
                    let gmPlaces = gmResponse["results"] as! [NSDictionary]
                    for dic in gmPlaces {
                        locations?.append(GMPlace(json: dic))
                    }
                } else if "ZERO_RESULTS" == status {
                    success = true
                    locations = []
                } else {
                    success = false
                }
            }
            completion(success: success, location: locations)
        }
    }
    
}
