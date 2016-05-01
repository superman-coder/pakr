//
//  ProfilePresenterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class ProfilePresenterImpl: NSObject, ProfilePresenter, OnProfileItemClickListener {
   
    weak var view: ProfileView!
    var model: ProfileDataModel
    var router: ProfileRouter
    var tracker: ProfileTracker
    var adapter: ProfileAdapter
    var authService: AuthService
    
    init(view: ProfileView, model: ProfileDataModel, router: ProfileRouter, tracker: ProfileTracker, adapter: ProfileAdapter) {
        self.view = view
        self.model = model
        self.router = router
        self.tracker = tracker
        self.adapter = adapter
        authService = WebServiceFactory.getAuthService()
        super.init()
    }
    
    func initView() {
       view.initView()
       adapter.setListener(self)
    }
    
    func getHeaderUser() -> User {
        return model.getHeaderUser()
    }
    
    func onProfileItemClick(order: Int) {
        switch order {
        case 0:
            router.goToAllPostParking()
            break
        case 1:
            router.goToPostScreen()
            break
        case 2:
            router.gotoAllBookmarkPage()
            break
        case 3:
            break
        case 4:
            break
        case 5:
            authService.logOut()
            router.gotoLogInScreen()
            break
        default:
            break
        }
    }
}