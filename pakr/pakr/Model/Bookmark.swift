//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class Bookmark {

    let bookmarkId: String!
    let topic: Topic!
    let user: User!
    let dateCreated: NSDate!

    init(bookmarkId: String!, user: User!, topic: Topic!, dateCreated: NSDate!) {
        self.bookmarkId = bookmarkId
        self.user = user
        self.dateCreated = dateCreated
        self.topic = topic
    }

}
