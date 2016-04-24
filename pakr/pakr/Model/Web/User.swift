//
//  User.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/5/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import Parse

class User: PFObject {

    @NSManaged var userId: String!
    
    var role: Role! {
        get {
            return Role(rawValue: self["role"] as! String)
        } set {
            self["role"] = newValue.rawValue
        }
    }

    @NSManaged var email: String!
    @NSManaged var dateCreated: NSDate!
    @NSManaged var name: String!
    @NSManaged var avatarUrl: String?
    
    var topics: [Topic]?
    var bookmarks: [Bookmark]?

    // some method of parse will call this. but because we have defined other custom constructor
    // this method won't exist anymore. will cause exception 'use of unimplemented initializer 'init()' for class parse.User'
    override init() {
        super.init()
    }
    
    init(userId: String!, role: Role!, email: String!, dateCreated: NSDate!, name: String!, avatarUrl: String?) {
        super.init()
        
        self.role = role
        self.email = email
        self.dateCreated = dateCreated
        self.name = name
        self.avatarUrl = avatarUrl
        self.userId = userId
    }
    
    init(dict: NSDictionary) {
        super.init()
        
        role = Role(rawValue: dict["role"] as! String)
        email = dict["email"] as! String
        dateCreated = dict["created"] as! NSDate
        name = dict["name"] as! String
        avatarUrl = dict["avatar"] as? String
        userId = dict["uid"] as! String
    }
    
    func toDictionary() -> NSDictionary {
        var dict:[String:AnyObject] = [:]
        /*
         self.role = role
         self.email = email
         self.dateCreated = dateCreated
         self.name = name
         self.avatarUrl = avatarUrl
         self.userId = userId
         */
        dict["role"] = role.rawValue
        dict["email"] = email
        dict["created"] = dateCreated
        dict["name"] = name
        if let avatar = avatarUrl {
            dict["avatar"] = avatar
        }
        dict["uid"] = userId
        
        return dict
    }
}

extension User: PFSubclassing {
    
    class func parseClassName() -> String {
        return Constants.Table.User
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}