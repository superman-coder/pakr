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

class LoginController: UIViewController, GIDSignInUIDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    // The sign-in flow has finished and was successful if |error| is |nil|.
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            print("LoginController")
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print("user id: \(userId)")
            print("giveName: \(givenName)")
            print("familiyName: \(familyName)")
            
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
}