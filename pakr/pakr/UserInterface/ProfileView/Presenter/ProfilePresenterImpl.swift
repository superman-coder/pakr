//
//  ProfilePresenterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class ProfilePresenterImpl: NSObject, ProfilePresenter {
   
    weak var view: ProfileView
    var model: ProfileDataModel
    var router: ProfileRouter
    var tracker: ProfileTracker
    
    init(view: ProfileView, model: ProfileDataModel, router: ProfileRouter, tracker: ProfileTracker) {
        self.view = view
        self.model = model
        self.router = router
        self.tracker = tracker
        super.init()
    }
    
    func initView() {
       view.initView()
    }
    
    func getHeaderUser() -> User {
        return model.getHeaderUser()
    }
}