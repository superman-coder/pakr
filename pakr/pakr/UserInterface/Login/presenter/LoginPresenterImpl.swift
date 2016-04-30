//
//  LoginPresenterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/28/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class LoginPresenterImpl: LoginPresenter, LoginListener {

    let loginManager: LoginDataManager
    let loginView: LoginView
    let router: LoginRouter
    let tracker: LoginTracker
    
    init(view: LoginView, manager: LoginDataManager, router: LoginRouter, tracker: LoginTracker) {
        self.loginView = view
        self.loginManager = manager
        self.router = router
        self.tracker = tracker
    }
    
    func initViews() {
        loginView.initViews()
        loginManager.setLoginListener(self)
        loginManager.initSocialLogin(loginView.getFacebookLoginButton())
    }
   
    func loginSuccess() {
        router.gotoMainScreen()
    }
}