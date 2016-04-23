//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

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
        
        // set again all attribute to none
        pref.setLoginMechanism(LoginMechanism.NONE)
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.currentUser = nil
    }
    
    func getLoginUser() -> User? {
        if !isLogin() {
            return nil
        }
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.currentUser
    }
    
    func isExistUser(emailAddress: String, success: User -> Void, error: Void -> Void) {
        let query = User.query()!
        query.whereKey("email", equalTo: emailAddress)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, errorMessage: NSError?) -> Void in
            if errorMessage == nil && objects?.count > 0 {
                // we always know this is unique result
                let user = objects![0] as! User
                 success(user)
            } else {
                error()
            }
        }
    }
    
    
    func registerUser(user: User, success: Void -> Void, error: NSError -> Void) {
        user.saveInBackgroundWithBlock{
            succeeded, errorMsg in
            if succeeded {
                user.userId = user.objectId
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                delegate.currentUser = user
                success()
            } else {
                error(errorMsg!)
            }
        }
    }
    
    func getUserByUserId(userId: String, success: User -> Void, error: Void -> Void) {
        let query = User.query()!
        query.whereKey("objectId", equalTo: userId)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, errorMessage: NSError?) -> Void in
            if errorMessage == nil && objects?.count > 0 {
                // we always know this is unique result
                let user = objects![0] as! User
                success(user)
            } else {
                error()
            }
        }
    }
}