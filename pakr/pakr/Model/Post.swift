//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class Post: NSObject {

    let postId: String!
    let user: User!
    let dateCreated: NSDate!
    let upvote: Int!
    let downvote: Int!

    init(postId: String!, user: User!, dateCreated: NSDate!) {
        self.postId = postId
        self.user = user
        self.dateCreated = dateCreated
        self.upvote = 0
        self.downvote = 0
    }

}
