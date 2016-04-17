//
//  IAuth.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

protocol SocialAuth {
    static func isLogin() -> Bool
    static func signOut()
    static func getLoginedUser() -> User!
    static func isValidatedWithUrl(url: NSURL) -> Bool
    static func loginSuccess()
}