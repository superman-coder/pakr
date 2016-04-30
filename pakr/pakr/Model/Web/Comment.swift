//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

class Comment: Post, ParseModelProtocol {

    /*
     let postId: String?
     let userId: String!
     x var user: User?
     let dateCreated: NSDate!
     */
    
    let PKContent = "content"
    let PKTitle = "title"
    let PKRating = "rating"
    let PKTopicId = "topicId"
    static let PKTopic = "topic"
    
    var topic: Topic!
    var topicId: String!
    var content: String!
    var title: String!
    var rating: Int = 0

    init(userId: String!, topicId: String, content: String!, title: String, rating: Int!) {
        super.init(userId: userId)
        self.topicId = topicId
        self.content = content
        self.title = title
        self.rating = rating
    }
    
    required init(pfObject: PFObject) {
        let userId = pfObject[Comment.PKPostUser].objectId
        super.init(userId: userId)
        postId = pfObject.objectId
        topicId = pfObject[PKTopicId] as! String
        dateCreated = pfObject.createdAt
        content = pfObject[PKContent] as! String
        title  = pfObject[PKTitle] as! String
        rating = pfObject[PKRating] as! Int
    }
    
    func toPFObject() -> PFObject {
        let pfObject = PFObject(className: Constants.Table.Comment)
        pfObject[Comment.PKTopic] = PFObject(withoutDataWithClassName: Constants.Table.Topic, objectId: topicId)
        pfObject[Comment.PKPostUser] = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        pfObject[PKContent] = content
        pfObject[PKTitle] = title
        pfObject[PKRating] = rating
        pfObject[PKTopicId] = topicId
        return pfObject
    }
    
}
