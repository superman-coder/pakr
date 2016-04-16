//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class AuthServiceImpl: AuthService {
    
    func isLogin() -> Bool {
        let mechanism = NSUserDefaults.standardUserDefaults().getLoginMechanism()
        if mechanism == LoginMechanism.GOOGLE {
            return GoogleAuth.isLogin()
        } else if mechanism == LoginMechanism.FACEBOOK {
            return FacebookAuth.isLogin()
        } else {
            return false
        }
    }

    func logOut() {
        let pref = NSUserDefaults.standardUserDefaults()
        if pref.getLoginMechanism() == LoginMechanism.GOOGLE {
            GoogleAuth.signOut()
        } else {
            FacebookAuth.signOut()
        }
        pref.setLoginMechanism(LoginMechanism.NONE)
    }
    
    func getLoginUser() -> User? {
        if !isLogin() {
            return nil
        }
        return nil
    }
}
