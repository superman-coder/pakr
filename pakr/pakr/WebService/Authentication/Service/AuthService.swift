//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

protocol AuthService {
    func isLogin() -> Bool
    func logOut()
    func getLoginUser() -> User?
    func isExistUser(emailAddress: String, success: User -> Void, error: Void -> Void)
    func registerUser(user: User, success: Void -> Void, error: NSError -> Void)
    func getUserByUserId(userId: String, success: User -> Void, error: Void -> Void)
    func authenticateParse(user: User, success: User -> Void, error: NSError -> Void)
}
