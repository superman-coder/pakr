//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class AuthServiceImpl: AuthService {
    
    func isLogin() -> Bool {
        return GoogleAuth.isLogin() || FacebookAuth.isLogin()
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
