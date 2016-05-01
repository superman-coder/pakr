//
//  LoginDataModelImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/28/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import Google
import Parse
import FBSDKLoginKit

class LoginDataManagerImpl: NSObject, LoginDataManager, GIDSignInDelegate, FBSDKLoginButtonDelegate  {
    
    var authService: AuthService
     var listener: LoginListener!
    
    override init() {
        authService = WebServiceFactory.getAuthService()
        super.init()
    }
   
    func setLoginListener(listener: LoginListener) {
        self.listener = listener
    }

    func initSocialLogin(facebookLoginButton: FBSDKLoginButton) {
        initGoogleLogin()
        initFacebookLogin(facebookLoginButton)
    }
    
    func initGoogleLogin() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func initFacebookLogin(facebookLoginButton: FBSDKLoginButton) {
        facebookLoginButton.readPermissions = ["public_profile", "email"]
        facebookLoginButton.delegate = self
    }
    
    // Google SignIn Callback: The sign-in flow has finished and was successful if |error| is |nil|.
    func signIn(signIn: GIDSignIn!, didSignInForUser googler: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            GoogleAuth.loginSuccess()
            let  user = GoogleAuth.getLoginedUser(googler)
            print (user.avatarUrl)
            print(user.email)
            print(user.name)
            self.authService.authenticateParse(user,
                 success: {
                    User -> Void in
                    self.listener.loginSuccess()
                },
                error: {
                    NSError -> Void in
            })
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        print("Google disconnect app")
    }
    
    // Facebook SignIn Callback
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error == nil) {
            FacebookAuth.loginSuccess()
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"]).startWithCompletionHandler({
                (connection, result, error) -> Void in
                if let data = result as? NSDictionary {
                    let email = data.objectForKey("email") as? String
                    let name = data.objectForKey("name") as? String
                    let avatarUrl = data.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String
                    let user = User(userId: "", role: Role.UserAuth, email: email, dateCreated: NSDate(), name: name, avatarUrl: avatarUrl)
                    self.authService.authenticateParse(user,
                        success: {
                            User -> Void in
                            self.listener.loginSuccess()
                        },
                        error: {
                            NSError -> Void in
                    })
                }
            })
        } else {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
}