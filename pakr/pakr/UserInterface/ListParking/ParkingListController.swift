//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class ParkingListController: UIViewController {
    
    @IBOutlet weak var parkingTableView: UITableView!
    
    internal var addressService: AddressService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
//        addressService.loadAddress()
    }
    
    func initTableView() {
        self.parkingTableView.registerNib(UINib(nibName: "ParkingResultCell", bundle: nil), forCellReuseIdentifier: "ParkingResultCell")
        self.parkingTableView.rowHeight = UITableViewAutomaticDimension
        self.parkingTableView.estimatedRowHeight = 10
    }
}



extension ParkingListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkingResultCell") as! ParkingResultCell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        /*
         UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
         footer.backgroundView.backgroundColor = [UIColor clearColor];
         */
        
        let footer = view as! UITableViewHeaderFooterView
        footer.backgroundView?.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}