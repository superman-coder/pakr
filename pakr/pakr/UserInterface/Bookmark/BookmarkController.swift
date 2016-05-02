//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class BookmarkController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var bookMarks: [Bookmark]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book Mark"
        
        self.tableView.registerNib(UINib(nibName: "ParkingResultCell", bundle: nil), forCellReuseIdentifier: "ParkingResultCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 10
        self.tableView.tableFooterView = UIView()
    
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        getData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BookmarkController.postBookMark(_:)), name: EventSignal.UpLoadBookMarkDone, object: nil)
    }
    
    //MARK:- Private method
    func reloadData(){
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        if bookMarks?.count > 0 {
            imageView.hidden = true
            self.tableView.reloadData()
        }else {
            imageView.hidden = false
            self.tableView.reloadData()
        }
    }
    
    func postBookMark(notification: NSNotification) {
        let bookMark = notification.userInfo!["bookMark"] as! Bookmark
        if bookMarks?.count > 0 {
            bookMarks?.insert(bookMark, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }else{
            bookMarks = [bookMark]
            reloadData()
        }
    }
    func  getData(){
        let user = WebServiceFactory.getAuthService().getLoginUser()
        WebServiceFactory.getAddressService().getAllBookMarksByUser((user?.objectId)!) { (bookMarks, error) in
            if error == nil {
                self.bookMarks = bookMarks
                self.reloadData()
            }else{
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
    }
}

extension BookmarkController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarks?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("ParkingResultCell", forIndexPath: indexPath) as! ParkingResultCell
        let bookMark = bookMarks![indexPath.row]
        cell.configWithTopic(bookMark.topic)
        return cell
    }
}