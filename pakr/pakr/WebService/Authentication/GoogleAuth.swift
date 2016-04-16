//
//  GoogleAuth.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import Google

class GoogleAuth {
    static func getInstance() -> GIDSignIn {
        return GIDSignIn.sharedInstance()
    }
    
    static func isLogin() -> Bool {
        return getInstance().hasAuthInKeychain()
    }
    
    static func signOut() {
        getInstance().signOut()
    }
    
    static func getLoginedUser() -> User! {
        return nil
    }
    
    static func loginSuccess() {
        NSUserDefaults.standardUserDefaults().setLoginMechanism(LoginMechanism.GOOGLE)
    }
}