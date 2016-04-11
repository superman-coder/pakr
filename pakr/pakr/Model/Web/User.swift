//
//  User.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/5/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class User: NSObject {

    let userId: String!
    let role: Role!
    let email: String!
    let dateCreated: NSDate!
    let name: String!
    let avatarUrl: String?
    var topics: [Topic]?
    var bookmarks: [Bookmark]?

    init(userId: String!, role: Role!, email: String!, dateCreated: NSDate!, name: String!, avatarUrl: String?) {
        self.email = email
        self.dateCreated = dateCreated
        self.name = name
        self.avatarUrl = avatarUrl
        self.role = role
        self.userId = userId
    }
}
