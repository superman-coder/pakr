//
//  ProfileDataManagerImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class ProfileDataModelImpl: NSObject, ProfileDataModel {
    let profileItemStr: [String] = [
        "All Parking Post",
        "Post new Lot",
        "Bookmark",
        "Comments",
        "Settings",
        "Log Out",
        ]
    
    let authService: AuthService!
    var currentUser: User!
    let profileItems: [ProfileItem]!
    
    override init() {
        authService = WebServiceFactory.getAuthService()
        currentUser = authService.getLoginUser()
       
        profileItems = []
        for (order, item) in profileItemStr.enumerate() {
            let item = ProfileItem(order: order, name: item)
            profileItems.append(item)
        }
        
        super.init()
    }
    
    func getHeaderUser() -> User {
        return currentUser
    }

    func getTotalItems() -> Int {
        return profileItems.count
    }
    
    func getItemWithOrder(order: Int) -> ProfileItem {
        return profileItems[order]
    }
}