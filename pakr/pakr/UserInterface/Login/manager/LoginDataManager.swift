//
//  LoginDataModel.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/28/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import Google

protocol LoginDataManager {
    func setLoginListener(listener: LoginListener)
    func initSocialLogin(facebookLoginButton: FBSDKLoginButton)
}