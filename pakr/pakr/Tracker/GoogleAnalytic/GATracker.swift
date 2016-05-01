//
//  GATracker.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

protocol GATracker {
    func trackLoginFail(loginType: String)
    func trackLoginSuccess(loginType: String, user: String)
    func trackLogout(user: String)
    func trackScreen(screen: String)
}