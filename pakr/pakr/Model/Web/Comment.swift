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
    
    let PKTopic = "topic"
    let PKContent = "content"
    
    let topicId:String!
    
    var topic: Topic?
    var content: String!

    init(userId: String!, topicId: String, content: String!) {
        self.topicId = topicId
        self.content = content
        super.init(userId: userId)
    }
    
    required init(pfObject: PFObject) {
        topicId = "0"
        super.init(userId: "0")
        postId = pfObject.objectId
        dateCreated = pfObject.createdAt
        userId = "0"
        
        
        let topic = pfObject[PKTopic] as! PFObject
        let user = pfObject[Comment.PKPostUser] as! PFObject
        
        content = pfObject[PKContent] as! String
        
        
    }
    
    func toPFObject() -> PFObject {
        let pfObject = PFObject(className: Constants.Table.Comment)
        pfObject[PKTopic] = PFObject(withoutDataWithClassName: Constants.Table.Topic, objectId: topicId)
        pfObject[Comment.PKPostUser] = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        pfObject[PKContent] = content
        
        return pfObject
    }
}
