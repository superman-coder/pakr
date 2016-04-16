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

extension NSUserDefaults {
    
    func getLoginMechanism() -> LoginMechanism {
       let loginMechanism = self.integerForKey(loginMechanismPref)
       return LoginMechanism(rawValue: loginMechanism)!
    }
   
    func setLoginMechanism(mechanism: LoginMechanism) {
        self.setInteger(mechanism.rawValue, forKey: loginMechanismPref)
        self.synchronize()
    }
}