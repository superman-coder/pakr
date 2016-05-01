//
//  AllPostAdapterImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class AllPostAdapterImpl: NSObject, AllPostAdapter {
    
    let tableView: UITableView!
    let model: AllPostModel
    weak var listener: OnAllPostItemClickListener!
    
    init(tableView: UITableView, model: AllPostModel) {
        self.tableView = tableView
        self.model = model
        
        self.tableView.registerNib(UINib(nibName: "ParkingResultCell", bundle: nil), forCellReuseIdentifier: "ParkingResultCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 10
        
        self.tableView.tableFooterView = UIView()
        
        super.init()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func refreshData() {
        tableView.reloadData()
    }
    
    func setListener(listener: OnAllPostItemClickListener) {
        self.listener = listener
    }
}

extension AllPostAdapterImpl: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        listener.onAllPostItemClick(indexPath.row)
    }
}

extension AllPostAdapterImpl: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  model.totalTopics()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkingResultCell") as! ParkingResultCell
        let topic = model.getTopicByOrder(indexPath.row)
        cell.configWithTopic(topic!)
        return cell
    }
}
