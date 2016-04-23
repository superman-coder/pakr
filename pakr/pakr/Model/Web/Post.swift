//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class Post: NSObject {

    let PKPostUser = "user"
    
    var postId: String?
    var userId: String!
    var user: User?
    var dateCreated: NSDate!
    
    init(userId: String!) {
        self.userId = userId
    }
}
