//
//  ProfileRouterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class ProfileRouterImpl: NSObject, ProfileRouter {
   
    let screen: ProfileController
    
   init(screen: ProfileController) {
       self.screen = screen
        super.init()
    }

    func goToPostScreen() {
        let postParkingController = PostParkingController(nibName: "PostParkingController", bundle: nil)
        screen.navigationController?.pushViewController(postParkingController, animated: true)
    }
    
    func goToAllPostParking() {
       screen.navigationController?.pushViewController(AllPostParkingTableViewController(), animated: true)
    }
    
    func gotoLogInScreen() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let loginController = LoginController(nibName: "LoginController", bundle: nil)
        delegate.window?.rootViewController = loginController
        delegate.window?.makeKeyAndVisible()
    }
    
    func gotoAllBookmarkPage() {
        
    }
}