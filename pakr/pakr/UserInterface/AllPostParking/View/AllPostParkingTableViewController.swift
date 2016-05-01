//
//  AllPostParkingTableViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/26/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MBProgressHUD

class AllPostParkingTableViewController: UITableViewController, AllPostView {
    var parkSearchResult: [Topic]! = []
    internal var addressService = WebServiceFactory.getAddressService()
   
    var presenter: AllPostPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let router = AllPostRouterImpl(controller: self)
        let model = AllPostModelImpl()
        let adapter = AllPostAdapterImpl(tableView: tableView, model: model)
        let tracker = AllPostTrackerImpl()
        presenter = AllPostPresenterImpl(view: self, model: model, router: router, adapter: adapter, tracker: tracker)
        
        presenter.initViews()
    }

    func initView() {
        self.title = "ALL POST PARKINGS"
    }
    
    func showProgressView() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    func hideProgressView() {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
}
