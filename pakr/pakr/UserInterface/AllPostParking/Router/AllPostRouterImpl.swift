//
//  AllPostRouterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class AllPostRouterImpl: NSObject, AllPostRouter {
    
    weak var controller: AllPostParkingTableViewController!
    
    init(controller: AllPostParkingTableViewController) {
        self.controller = controller
        super.init()
    }
    
    func gotoDetailParkingScreen(topic: Topic) {
        let detailViewController = DetailParkingController(nibName: "DetailParkingController", bundle: nil)
        detailViewController.parking = topic.parking
        controller.navigationController?.pushViewController(detailViewController, animated: true)
    }
}