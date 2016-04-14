//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class ParkingListController: UIViewController {
    
    @IBOutlet weak var parkingTableView: UITableView!
    var parkSearchResult: [Topic]! = []
    
    internal var addressService: AddressService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
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
        return parkSearchResult.count
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
       let footer = view as! UITableViewHeaderFooterView
        footer.backgroundView?.backgroundColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let topic = self.parkSearchResult[indexPath.section];
        let parking = topic.parking
        
        let detailVc = DetailParkingController(nibName: "DetailParkingController", bundle: nil)
        detailVc.parking = parking
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}