//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

class Bookmark:Post, ParseModelProtocol {
    let PKTopicId = "topicId"
    var topicId: String!
    var topic: Topic!
    
    init(userId: String!, topicId: String!, topic: Topic!) {
        self.topicId = topicId
        self.topic = topic
        super.init(userId: userId)
    }
    
    required init(pfObject: PFObject) {
        topicId = pfObject[PKTopicId] as! String

        let userId = pfObject[Bookmark.PKPostUser].objectId
        super.init(userId: userId)
        self.dateCreated = pfObject.createdAt
        self.postId = pfObject.objectId
    }
    
    func toPFObject() -> PFObject {
        let pfObject = PFObject(className: Constants.Table.Bookmark)
        pfObject[Bookmark.PKPostUser] = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        pfObject[PKTopicId] = topicId
        return pfObject
    }

}
