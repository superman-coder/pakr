//
//  AuthenPreferences.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

enum LoginMechanism: Int{
    case NONE = 0
    case FACEBOOK
    case GOOGLE
}

let loginMechanismPref = "LoginMechanismPref"
let kUserDataKey = "UserData"

extension NSUserDefaults {
    
    func getLoginMechanism() -> LoginMechanism {
       let loginMechanism = self.integerForKey(loginMechanismPref)
       return LoginMechanism(rawValue: loginMechanism)!
    }
   
    func setLoginMechanism(mechanism: LoginMechanism) {
        self.setInteger(mechanism.rawValue, forKey: loginMechanismPref)
        self.synchronize()
    }
    
    func saveCurrentUser(user:User?) {
        if let user = user {
            let data = try! NSJSONSerialization.dataWithJSONObject(user.toDictionary(), options: [])
            self.setObject(data, forKey: kUserDataKey)
        } else {
            self.setObject(nil, forKey: kUserDataKey)
        }
        
        self.synchronize()
    }
    
    func currentUser() -> User? {
        var user: User? = nil
        let data = self.objectForKey(kUserDataKey) as? NSData
        if let data = data {
            let json = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
            user = User(dict: json)
        }
        user?.objectId = user?.userId
        return user
    }
}