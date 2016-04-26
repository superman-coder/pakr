//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

class AuthServiceImpl: AuthService {
    
    var currentUser: User?
    let lock = NSLock()
    
    class var sharedInstance: AuthServiceImpl {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: AuthServiceImpl? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = AuthServiceImpl()
        }
        return Static.instance!
    }
    
    func isLogin() -> Bool {
        return NSUserDefaults.standardUserDefaults().getLoginMechanism() != LoginMechanism.NONE
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
        NSUserDefaults.standardUserDefaults().saveCurrentUser(nil)
        currentUser = nil
    }
    
    func getLoginUser() -> User? {
        if (self.isLogin() && self.currentUser == nil) {
            lock.lock()
            if (currentUser == nil) {
                self.currentUser = NSUserDefaults.standardUserDefaults().currentUser()
            }
             lock.unlock()
        }
        return currentUser
    }
    
func authenticateParse(user: User, success: User -> Void, error: NSError -> Void) {
    isExistUser(user.email,
                // this user has already registered
        success: {
            (user: User) -> Void in
            print("User has registered")
            print("zzz user: \(user.name)")
            NSUserDefaults.standardUserDefaults().saveCurrentUser(user)
            success(user)
        },
        // not register yet. start to register
        error: {
            () -> () in
            print("not register yet")
            self.registerUser(user,
                success: {
                    Void -> Void in
                    print("register success AAAAAAAAAAAAAAAAAAAAA")
                    NSUserDefaults.standardUserDefaults().saveCurrentUser(user)
                    success(user)
                }, error: {
                    (errorMsg: NSError) -> Void in
                    print("register fail")
                    error(errorMsg)
                }
            )
    })
}

func isExistUser(emailAddress: String, success: User -> Void, error: Void -> Void) {
    let query = User.query()!
    query.whereKey("email", equalTo: emailAddress)
    query.findObjectsInBackgroundWithBlock {
        (objects: [PFObject]?, errorMessage: NSError?) -> Void in
        if errorMessage == nil && objects?.count > 0 {
            // we always know this is unique result
            let user = objects![0] as! User
            user.userId = user.objectId
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
            user.userId = user.objectId
            success(user)
        } else {
            error()
        }
    }
}
}