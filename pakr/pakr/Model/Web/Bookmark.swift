//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

class Bookmark:Post, ParseModelProtocol {
    let PKTopic = "topic"
    let PKUser = "user"
    let PKTopicId = "topicId"
    
    let topic: Topic!
    
    init(userId: String!, topic: Topic!) {
        self.topic = topic
        super.init(userId: userId)
    }
    
    required init(pfObject: PFObject) {
        topic = Topic(pfObject:pfObject[PKTopic] as! PFObject)
        let userId = pfObject[Bookmark.PKPostUser].objectId
        super.init(userId: userId)
        self.dateCreated = pfObject.createdAt
        self.postId = pfObject.objectId
    }
    
    func toPFObject() -> PFObject {
        let pfObject = PFObject(className: Constants.Table.Bookmark)
        pfObject[PKUser] = user
        pfObject[PKTopic] = topic.toPFObject()
        return pfObject
    }

}
