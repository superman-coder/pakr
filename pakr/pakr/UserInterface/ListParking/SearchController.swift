//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var parkingTableView: UITableView!
    var parkSearchResult: [Topic]! = []
    
    var searchTriggerTimer:NSTimer?
    
    internal var addressService = WebServiceFactory.getAddressService()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
    }
    
    func initTableView() {
        parkingTableView.registerNib(UINib(nibName: "ParkingResultCell", bundle: nil), forCellReuseIdentifier: "ParkingResultCell")
        
        parkingTableView.rowHeight = UITableViewAutomaticDimension
        parkingTableView.estimatedRowHeight = 10
        
        parkingTableView.delegate = self
        parkingTableView.dataSource = self
    }
    
    func initSearchBar() {
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkingResultCell") as! ParkingResultCell
        cell.configWithTopic(parkSearchResult[indexPath.row])
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

extension SearchController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            parkSearchResult.removeAll()
            parkingTableView.reloadData()
            return
        }
        
        searchTriggerTimer?.invalidate()
        searchTriggerTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(SearchController.requestSearchPlaces(_:)), userInfo: searchText, repeats: false)
    }
    
    func requestSearchPlaces(sender:NSTimer) {
        let searchText = sender.userInfo as! String
        addressService.getNearByParkingByAddressName(searchText, radius: 800, success: { topics in
            self.parkSearchResult.removeAll()
            self.parkSearchResult.appendContentsOf(topics)
            self.parkingTableView.reloadData()
            }) { error in
                
        }
    }
    
}

