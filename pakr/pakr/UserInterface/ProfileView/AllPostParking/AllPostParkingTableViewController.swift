//
//  AllPostParkingTableViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/26/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MBProgressHUD

class AllPostParkingTableViewController: UITableViewController {
    var parkSearchResult: [Topic]! = []
    internal var addressService = WebServiceFactory.getAddressService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ALL POST PARKINGS"
        self.tableView.registerNib(UINib(nibName: "ParkingResultCell", bundle: nil), forCellReuseIdentifier: "ParkingResultCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 10
        
        
        let  authenService = WebServiceFactory.getAuthService()
        let user = authenService.getLoginUser()
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        addressService.getAllParkingByUser((user?.userId)!, success: { (topic:[Topic]) in
            self.parkSearchResult = topic
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            self.tableView.reloadData()
        }) { (error: NSError) in
            print(error.domain)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkSearchResult.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkingResultCell") as! ParkingResultCell
        cell.configWithTopic(parkSearchResult[indexPath.row])
        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = DetailParkingController(nibName: "DetailParkingController", bundle: nil)
        detailViewController.parking = parkSearchResult[indexPath.row].parking
        
        var controllers = self.navigationController?.viewControllers
        controllers?.removeLast()
        controllers?.append(detailViewController)
        self.navigationController?.setViewControllers(controllers!, animated: true)
        
    }

}
