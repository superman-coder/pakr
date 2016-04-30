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

class LoginController: UIViewController, LoginView, GIDSignInUIDelegate {
    
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginDataManager = LoginDataManagerImpl()
        let loginTracker = LoginTracker()
        let router = LoginRouterImpl()
        presenter = LoginPresenterImpl(view: self, manager: loginDataManager, router: router, tracker: loginTracker)
        presenter.initViews()
    }
    
    func getFacebookLoginButton() -> FBSDKLoginButton {
        return facebookLoginButton
    }
   
    func initViews() {
        googleLoginButton.colorScheme = GIDSignInButtonColorScheme.Light
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}