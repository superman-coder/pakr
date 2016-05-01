//
//  LoginRouterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class LoginRouterImpl: NSObject, LoginRouter {
    func gotoMainScreen() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let rootViewController = PakrTabBarController()
        delegate.window?.rootViewController = rootViewController
        delegate.window?.makeKeyAndVisible()
    }
}