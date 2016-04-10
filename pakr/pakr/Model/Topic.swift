//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

@objc class Topic: Post {

    let parking: Parking!
    var comments: [Comment]?
    var rating: Int!

    init(topicId: String!, userId: String!, date: NSDate!, parking: Parking!, rating: Int!) {
        self.rating = rating
        self.parking = parking
        super.init(postId: topicId, userId: userId, dateCreated: date)
    }
}
