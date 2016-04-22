//
//  Parking.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/5/16.
//  Copyright © 2016 Pakr. All rights reserved.
//
// 2016

import UIKit
import Parse

let PKBusiness = "business"
let PKParkingName = "parking_name"
let PKCapacity = "capacity"
let PKAddressName = "address"
let PKCoordinate = "coordinate"
let PKVerified = "verified"
let PKVehicles = "vehicles"
let PKRegions = "regions"
let PKImageUrls = "images"
let PKSchedule = "schedule"

let PKBusinessName = "business_name"
let PKBusinessDesc = "business_desc"
let PKBusinessPhone = "business_phone"

let PKCoordinateLat = "coord_lat"
let PKCoordinateLng = "coord_lng"

let PKVehicleType = "vehicle_type"
let PKVehiclePriceMin = "vehicle_price_min"
let PKVehiclePriceMax = "vehicle_price_max"
let PKVehicleNote = "vehicle_note"

let PKScheduleOpenTime = "schedule_open"
let PKScheduleCloseTime = "schedule_close"

class Parking: NSObject {

    let business: Business!
    let dateCreated: NSDate?
    let parkingName: String!
    let capacity: Int!
    var addressName: String!
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
    
    init(dic: NSDictionary){
        var businessDescription = ""
        if dic["worktime_details"] != nil {
           businessDescription = dic["worktime_details"] as! String
        }
        var name = ""
        if dic["name"] != nil {
            name = dic["name"] as! String
        }
         business = Business(businessName:name, businessDescription: businessDescription , telephone: "")
         dateCreated = nil
         parkingName = name
         capacity = 0
        addressName = ""
        if dic["addr"] != nil {
            addressName = dic["addr"] as! String
        }
        
        let loc = dic["loc"] as! NSDictionary
        let coordinates = loc["coordinates"] as!NSArray
         coordinate = Coordinate(latitude: coordinates.lastObject as! Double, longitude: coordinates.firstObject as! Double)
         verify = false
        
        let vehicles = NSMutableArray()
        let vehicleType = dic["vehicle_type"] as! NSDictionary

        
        for key in vehicleType.allKeys{
            var max = ""
            var min = ""
            var note = ""
        let keyString = key as! String
            if dic ["price"] != nil{
                let price = dic ["price"] as! NSDictionary
                let  dicPrice = price[keyString] as! NSDictionary
                if dicPrice["max"] != nil {
                     max = dicPrice["max"] as!String
                }
                if dicPrice["min"] != nil {
                    min = dicPrice["min"] as!String
                }
                
            }

            if dic["note"] != nil {
                note = dic["note"] as! String
            }
            switch keyString {
            case "bike":
                let vehicleDetail = VehicleDetail(vehicleType: VehicleType.Bike, minPrice: min, maxPrice: max, note: note)
                vehicles.addObject(vehicleDetail)
            case "car":
                let vehicleDetail = VehicleDetail(vehicleType: VehicleType.Car, minPrice: min, maxPrice: max, note: note)
                vehicles.addObject(vehicleDetail)
            case "motor":
                let vehicleDetail = VehicleDetail(vehicleType: VehicleType.Motor, minPrice: min, maxPrice: max, note: note)
                vehicles.addObject(vehicleDetail)
            case "general":
                let vehicleDetail = VehicleDetail(vehicleType: VehicleType.General, minPrice: min, maxPrice: max, note: note)
                vehicles.addObject(vehicleDetail)
            default:
                break
            }
        }
         vehicleList =  vehicles.copy() as! [VehicleDetail]
        
         region = dic["region"] as! [String]
//         imageUrl = dic["pictures"] as? [String]
        imageUrl = ["https://www.dropbox.com/s/crpldiixsjpsdwu/do-xe-tu-dong-puzzle.jpg?dl=0"]
        let scheduls = NSMutableArray()
        var worktimes = []
        if dic["worktime"] != nil {
           worktimes = dic["worktime"] as! NSArray
        }
       
        for worktime in worktimes{
            var openTime = ""
            var closeTime = ""
            
//            let worktime1 = worktime as!NSArray
            if worktime.isKindOfClass(NSNull) {
                print("")
            }
            if !worktime.firstObject!!.isKindOfClass(NSNull){
                openTime = worktime.firstObject as! String
            }
            if !worktime.lastObject!!.isKindOfClass(NSNull){
                closeTime = worktime.lastObject as! String
            }

            let timeRange = TimeRange(openTime: openTime, closeTime: closeTime)
            scheduls.addObject(timeRange)
        }
         schedule = scheduls.copy() as! [TimeRange]
    }
}

extension Parking: ParseModelProtocol {
    /*
     let business: Business!
     let dateCreated: NSDate?
     let parkingName: String!
     let capacity: Int!
     var addressName: String!
     let coordinate: Coordinate!
     var verify: Bool! = false
     var vehicleList: [VehicleDetail]!
     var region: [String]!
     var imageUrl: [String]?
     var schedule: [TimeRange]!
     
     let PKParkingName = "parking_name"
     let PKCapacity = "capacity"
     let PKAddressName = "address"
     let PKCoordinate = "coordinate"
     let PKVerified = "verified"
     let PKVehicles = "vehicles"
     let PKRegions = "regions"
     let PKImageUrls = "images"
     let PKSchedule = "schedule"
     
     let PKBusinessName = "business_name"
     let PKBusinessAddress = "business_address"
     let PKBusinessPhone = "business_phone"
     
     let PKCoordinateLat = "coord_lat"
     let PKCoordinateLng = "coord_lng"
     
     let PKVehicleType = "vehicle_type"
     let PKVehiclePriceMin = "vehicle_price_min"
     let PKVehiclePriceMax = "vehicle_price_max"
     let PKVehicleNote = "vehicle_note"
     
     let PKScheduleOpenTime = "schedule_open"
     let PKScheduleCloseTime = "schedule_close"
     
     */
    
    func toPFObject() -> PFObject {
        let parkingPF = PFObject()
        
        parkingPF[PKParkingName] = parkingName
        parkingPF[PKCapacity] = capacity
        parkingPF[PKAddressName] = addressName
        parkingPF[PKVerified] = verify
        parkingPF[PKRegions] = region
        parkingPF[PKImageUrls] = imageUrl == nil ? NSNull() : imageUrl
        
        let businessPF = PFObject()
        businessPF[PKBusinessName] = business.businessName
        businessPF[PKBusinessDesc] = business.businessDescription
        businessPF[PKBusinessPhone] = business.telephone
        parkingPF[PKBusiness] = businessPF
        
        let coordPF = PFObject()
        coordPF[PKCoordinateLat] = coordinate.latitude
        coordPF[PKCoordinateLng] = coordinate.longitude
        parkingPF[PKCoordinate] = coordPF
        
        var vehicles: [PFObject] = []
        for v in vehicleList {
            let pVehicle = PFObject()
            pVehicle[PKVehicleType] = v.vehicleType.rawValue
            pVehicle[PKVehiclePriceMin] = v.minPrice
            pVehicle[PKVehiclePriceMax] = v.maxPrice
            pVehicle[PKVehicleNote] = v.note
            vehicles.append(pVehicle)
        }
        parkingPF[PKVehicles] = vehicles
        
        var timeRanges: [PFObject] = []
        for range in schedule {
            let r = PFObject()
            r[PKScheduleOpenTime] = range.openTime
            r[PKScheduleCloseTime] = range.closeTime
            timeRanges.append(r)
        }
        parkingPF[PKSchedule] = timeRanges
        
        return parkingPF
    }
}






