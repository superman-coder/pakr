//
//  AllPostPresenterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class AllPostPresenterImpl: NSObject, AllPostPresenter, OnAllPostItemClickListener {
   
    weak var view: AllPostView!
    let router: AllPostRouter
    let model: AllPostModel
    let adapter: AllPostAdapter
    let tracker: AllPostTracker
    let authService: AuthService
    let addressService: AddressService
    
    init(view: AllPostView, model: AllPostModel, router: AllPostRouter, adapter:  AllPostAdapter, tracker: AllPostTracker) {
        self.view = view
        self.router = router
        self.model = model
        self.tracker = tracker
        self.adapter = adapter
        authService = WebServiceFactory.getAuthService()
        addressService = WebServiceFactory.getAddressService()
        
        super.init()
    }
    
    func initViews() {
        adapter.setListener(self)
        view.initView()
        view.showProgressView()
        
        let user = authService.getLoginUser()
        addressService.getAllParkingByUser((user?.userId)!,
            success: {
                (topic:[Topic]) in
                self.model.setTopic(topic)
                self.view.hideProgressView()
                self.adapter.refreshData()
            }) { (error: NSError) in
            print(error.domain)
        }
    }
    
    func onAllPostItemClick(order: Int) {
        let topic = model.getTopicByOrder(order)
        router.gotoDetailParkingScreen(topic!)
    }
}