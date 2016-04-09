//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class Topic: Post {

    let parking: Parking!
    var comments: [Comment]?

    init(topicId: String!, user: User!, date: NSDate!, parking: Parking!) {
        self.parking = parking
        super.init(postId: topicId, user: user, dateCreated: date)
    }
}
