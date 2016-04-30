//
//  ProfileAdapter.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class ProfileAdapterImpl: NSObject, ProfileAdapter {
    
    let tableView: UITableView
    let model: ProfileDataModel
    weak var listener: OnProfileItemClickListener!
    
    init(tableView: UITableView, model: ProfileDataModel) {
        self.tableView = tableView
        self.model = model
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setListener(listener: OnProfileItemClickListener) {
        self.listener = listener
    }
}

extension ProfileAdapterImpl: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        listener.onProfileItemClick(row)
    }
}


extension ProfileAdapterImpl: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return model.getTotalItems()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let item = model.getItemWithOrder(row)
        cell.textLabel?.text = item.name
        cell.targetForAction(#selector(ProfileAdapterImpl.cellClickEvent), withSender: cell)
        return cell
    }
    
    func cellClickEvent(sender: ExtendedCell) {
        let row = sender.rowIndex()
        print("click: \(row)")
        
    }
}

