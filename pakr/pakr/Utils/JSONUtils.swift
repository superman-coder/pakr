//
//  JSONUtils.swift
//  pakr
//
//  Created by nguyen trung quang on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import Parse

class JSONUtils: NSObject {

    class var dummyParkingList: [Parking] {
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
    
    class var dummyTopicList: [Topic] {
        let path = NSBundle.mainBundle().pathForResource("parkings", ofType: "json")
        let data = try! NSData(contentsOfURL: NSURL(fileURLWithPath: path!), options:NSDataReadingOptions.DataReadingMappedIfSafe)
        let jsonObj =  try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSArray
        var topics:[Topic] = []
        for dic in jsonObj{
            let parking = Parking(dic: dic as! NSDictionary)
//            let topic = Topic(topicId: "0", userId: "0", date: NSDate(), parking: parking, rating: 0)
//            topics.append(topic)
        }
        return topics
    }
    
    class func saveParkingList() {
        let parkinglist = dummyParkingList
        let user = WebServiceFactory.getAuthService().getLoginUser()
        var objects = [PFObject]()
        for parking in parkinglist {
            let topic = Topic(userId: user?.userId, parking: parking, rating: 0)
            objects.append(topic.toPFObject())
        }
        PFObject.saveAllInBackground(objects)
    }
}
