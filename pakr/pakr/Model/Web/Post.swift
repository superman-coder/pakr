//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class Post: NSObject {

    let postId: String!
    let userId: String!
    var user: User?
    let dateCreated: NSDate!
    
    init(postId: String!, userId: String!, dateCreated: NSDate!) {
        self.postId = postId
        self.userId = userId
        self.dateCreated = dateCreated
    }
}
