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
    var rating: Int!

    init(userId: String!, parking: Parking!, rating: Int!) {
        self.rating = rating
        self.parking = parking
        super.init(userId: userId)
    }
    
    required init(pfObject: PFObject) {
        let parking = pfObject[Topic.PKParking] as! PFObject
        self.parking = Parking(pfObject: parking)
        super.init(userId: "0")
    }
    
    func toPFObject() -> PFObject {
        let pfObject = PFObject(className: Constants.Table.Topic)
        pfObject[PKPostUser] = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        pfObject[Topic.PKRating] = rating
        pfObject[Topic.PKParking] = parking.toPFObject()
        return pfObject
    }
}

