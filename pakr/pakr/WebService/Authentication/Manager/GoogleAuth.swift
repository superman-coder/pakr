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

class GoogleAuth: SocialAuth {
    
   class var sharedInstance : GoogleAuth {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : GoogleAuth? = nil
        }
        dispatch_once(&Static.token) {
            Static.instance = GoogleAuth()
        }
        return Static.instance!
    }
    
    static func getInstance() -> GIDSignIn {
        GIDSignIn.sharedInstance().shouldFetchBasicProfile = true
        return GIDSignIn.sharedInstance()
    }
    
    static func isLogin() -> Bool {
        return getInstance().hasAuthInKeychain()
    }
    
    static func signOut() {
        getInstance().signOut()
    }
    
    static func getLoginedUser(googler: GIDGoogleUser) -> User! {
        let user = User(userId: "", role: Role.UserAuth, email: googler.profile.email, dateCreated: NSDate(), name: googler.profile.name, avatarUrl: googler.profile.imageURLWithDimension(120).absoluteString)
        return user
    }
    
    static func loginSuccess() {
        NSUserDefaults.standardUserDefaults().setLoginMechanism(LoginMechanism.GOOGLE)
    }
    
    static func isValidatedWithUrl(url: NSURL) -> Bool {
        return url.scheme.hasPrefix(NSBundle.mainBundle().bundleIdentifier!) || url.scheme.hasPrefix("com.googleusercontent.apps.")
    }
}