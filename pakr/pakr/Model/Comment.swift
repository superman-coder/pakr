//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class Comment: Post {

    let topic: Topic!
    var content: String!

    init(commentId: String!, userId: String!, dateCreated: NSDate!, topic: Topic!, content: String!) {
        self.topic = topic
        super.init(postId: commentId, userId: userId, dateCreated: dateCreated)
    }
}
