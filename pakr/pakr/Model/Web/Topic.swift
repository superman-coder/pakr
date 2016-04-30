//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

@objc class Topic: Post, ParseModelProtocol {
    
    /*
     let postId: String?
     let userId: String!
     var user: User?
     let dateCreated: NSDate!
     */
    
    static let PKParking = "parking"
    static let PKRating = "rating"
    
    let parking: Parking!
    var comments: [Comment]?
    var rating: Int = 0

    init(userId: String!, parking: Parking!, rating: Int!) {
        self.rating = rating
        self.parking = parking
        super.init(userId: userId)
    }
    
    required init(pfObject: PFObject) {
        let parking = pfObject[Topic.PKParking] as! PFObject
        self.parking = Parking(pfObject: parking)
        self.rating = pfObject[Topic.PKRating] as! Int
        
        let userId = pfObject[Topic.PKPostUser].objectId
        
        super.init(userId: userId)
        self.dateCreated = pfObject.createdAt
        self.postId = pfObject.objectId
    }
    
    func toPFObject() -> PFObject {
        let pfObject = PFObject(className: Constants.Table.Topic)
        pfObject[Topic.PKPostUser] = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        pfObject[Topic.PKRating] = rating
        pfObject[Topic.PKParking] = parking.toPFObject()
        return pfObject
    }
}

