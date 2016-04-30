//
//  LoginView.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import FBSDKLoginKit

protocol LoginView: class{
   func initViews()
    func getFacebookLoginButton() -> FBSDKLoginButton
}