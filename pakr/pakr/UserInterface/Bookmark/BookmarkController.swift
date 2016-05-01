//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

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
    }
    
    //MARK:- Private method
    func reloadData(){
        if bookMarks?.count > 0 {
            imageView.hidden = true
            self.tableView.reloadData()
        }else {
            imageView.hidden = false
            self.tableView.reloadData()
        }
    }
}

extension BookmarkController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarks?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("ParkingResultCell", forIndexPath: indexPath) as! ParkingResultCell
        return cell
    }
}