//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

enum Role: String {
    case Admin = "Admin"
    case BusinessAuth = "BusinessAuth"
    case BusinessNotAuth = "BusinessNotAuth"
    case UserAuth = "UserAuth"
    case UserNotAuth = "UserNotAuth"
    case UserDeleted = "UserDeleted"
}
