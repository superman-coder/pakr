//
//  LoginController.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/16/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import Google
import FBSDKLoginKit

class LoginController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            GoogleAuth.loginSuccess()
            mainScreen()
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
            mainScreen()
        } else {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func parseServer() {
        
    }
    
    func mainScreen() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let rootViewController = PakrTabBarController()
        delegate.window?.rootViewController = rootViewController
        delegate.window?.makeKeyAndVisible()
        
    }
}
