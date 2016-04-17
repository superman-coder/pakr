//
//  FacebookAuth.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FacebookAuth: SocialAuth {
    static func isLogin() -> Bool {
       return FBSDKAccessToken.currentAccessToken() != nil
    }
    
    static func signOut() {
       FBSDKLoginManager().logOut()
    }
    
    static func getLoginedUser() -> User! {
        return nil
    }
    
    static func isValidatedWithUrl(url: NSURL) -> Bool {
        return url.scheme.hasPrefix("fb\(FBSDKSettings.appID())") && url.host == "authorize"
    }
    
    static func loginSuccess() {
        NSUserDefaults.standardUserDefaults().setLoginMechanism(LoginMechanism.FACEBOOK)
    }
}