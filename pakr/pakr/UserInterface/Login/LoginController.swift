//
//  LoginController.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/16/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Google
import Parse

class LoginController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = WebServiceFactory.getAuthService()
        
        configureGoogleSignIn()
        configureFacebookLogin()
    }
    
    func configureGoogleSignIn() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        // we move this delegate to Login Screen. So we can control screen transition of Google and Facebook both on this class
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func configureFacebookLogin() {
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
            authenticateParse(user)
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
                    self.authenticateParse(user)
                }
            })
        } else {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func authenticateParse(user: User) {
       authService.isExistUser(user.email,
            // this user has already registered
            success: {
                (user: User) -> Void in
                print("User has registered")
                self.mainScreen()
            },
            // not register yet. start to register
            error: {
                () -> () in
                print("not register yet")
                self.authService.registerUser(user,
                    success: {
                        Void -> Void in
                        print("register success")
                        self.mainScreen()
                    }, error: {
                        NSError -> Void in
                        print("register fail")
                    }
                )
        })
    }
   
    func mainScreen() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let rootViewController = PakrTabBarController()
        delegate.window?.rootViewController = rootViewController
        delegate.window?.makeKeyAndVisible()
        
    }
}
