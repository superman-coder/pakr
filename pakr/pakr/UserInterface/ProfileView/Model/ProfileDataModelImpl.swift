//
//  ProfileDataManagerImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class ProfileDataModelImpl: NSObject, ProfileDataModel {
    static let ProfileItems: [String] = [
        "All Parking Post",
        "Post new Lot",
        "Bookmark",
        "Comments",
        "Settings",
        "Log Out",
        ]
    
    let authService: AuthService!
    var currentUser: User!
    
    override init() {
        authService = WebServiceFactory.getAuthService()
        let currentUser = authService.getLoginUser()
//        if let currentUser = currentUser {
//            if let avatar = currentUser.avatarUrl {
//                self.profileImageView.setImageWithURL(NSURL(string: avatar)!, placeholderImage: nil)
//            }
//        }
//        super.init()
        super.init()
    }
    
    func getHeaderUser() -> User {
        return currentUser
    }

}