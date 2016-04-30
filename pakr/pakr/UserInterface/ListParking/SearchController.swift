//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class SearchController: UIViewController {
    
    @IBOutlet weak var emptyView: UIView!
    // Inside status view (empty view)
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var parkingTableView: UITableView!
    
    @IBOutlet weak var tableBottomToSuperViewConstraint: NSLayoutConstraint!
    
    var isQuering = false
    var currentSearchText:String? = nil
    var latestSearchText:String? = nil
    var parkSearchResult: [Topic]! = []
    var searchTriggerTimer:NSTimer?
    
    internal var addressService = WebServiceFactory.getAddressService()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
        
        showWelcomeInStatusView()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
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
        searchBar.tintColor = UIColor.primaryColor()
        searchBar.autocorrectionType = .No
        searchBar.placeholder = "Type an address..."
    }
    
    func reloadData() {
        parkingTableView.reloadData()
    }
    
    func keyboardWillShow(notification:NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        let keyboardSizeValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardSizeValue.CGRectValue().size
        let animDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animCurveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(animDurationValue.doubleValue,
                                   delay: 0,
                                   options: UIViewAnimationOptions(rawValue: UInt(animCurveValue.integerValue << 16)),
                                   animations: {
                                    self.tableBottomToSuperViewConstraint.constant = keyboardSize.height
                                    self.view.layoutIfNeeded()
            },
                                   completion: nil
        )
    }
    
    func keyboardWillHide(notification:NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        let animDurationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animCurveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(animDurationValue.doubleValue,
                                   delay: 0,
                                   options: UIViewAnimationOptions(rawValue: UInt(animCurveValue.integerValue << 16)),
                                   animations: {
                                    self.tableBottomToSuperViewConstraint.constant = 0
                                    self.view.layoutIfNeeded()
            },
                                   completion: nil
        )
    }
    @IBAction func onTapView(sender: AnyObject) {
        self.view.endEditing(false)
    }
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkingResultCell") as! ParkingResultCell
        cell.configWithTopic(parkSearchResult[indexPath.section])
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
        return 16
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
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        latestSearchText = searchText
        if searchText.characters.count == 0 {
            handleSearchResult(nil, error: nil)
            return
        }
        if (!isQuering) {
            requestSearchPlaces(searchText)
        }
    }
    
    func requestSearchPlaces(searchText: String) {
        isQuering = true
        self.currentSearchText = searchText
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        addressService.getNearByParkingByAddressName(searchText, radius: 800, success: { topics in
            self.isQuering = false
            self.handleSearchFinished()
            self.handleSearchResult(topics, error: nil)
            }) { error in
                self.isQuering = false
                self.handleSearchFinished()
               self.handleSearchResult(nil, error: error)
        }
    }
    
    func handleSearchFinished() {
        if latestSearchText != nil && currentSearchText != nil && currentSearchText != latestSearchText {
            currentSearchText = latestSearchText
            requestSearchPlaces(currentSearchText!)
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func handleSearchResult(topics:[Topic]?, error:NSError?) {
        if let error = error {
            showStatusErrorInStatusView(error)
        }
        
        self.parkSearchResult.removeAll()
        if let topics = topics {
            self.parkSearchResult.appendContentsOf(topics)
        }
        
        if self.parkSearchResult.count > 0 {
            parkingTableView.hidden = false
            emptyView.hidden = true
        } else {
            showNoDataStatusInStatusView()
            parkingTableView.hidden = true
            emptyView.hidden = false
        }
        reloadData()
    }
    
    func showStatusErrorInStatusView(error:NSError) {
        statusImageView.image = UIImage(named: "angry")
        statusLabel.text = "Oops, something went wrong!"
    }
    
    func showWelcomeInStatusView() {
        statusImageView.image = UIImage(named: "troll")
        statusLabel.text = "Let's search for parking lots"
    }
    
    func showNoDataStatusInStatusView() {
        statusImageView.image = UIImage(named: "troll")
        statusLabel.text = "No data there"
    }
}

