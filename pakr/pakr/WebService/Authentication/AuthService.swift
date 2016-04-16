//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

protocol AuthService {
    func isLogin() -> Bool
    func logOut()
    func getLoginUser() -> User?
}
