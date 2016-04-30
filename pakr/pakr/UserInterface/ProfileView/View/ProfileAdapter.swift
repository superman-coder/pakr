//
//  ProfileAdapter.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class ProfileAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        super.init()
    }
}

extension ProfileAdapter: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        switch row {
        case 0:
            self.navigationController?.pushViewController(AllPostParkingTableViewController(), animated: true)
            break
        case 1:
            let postParkingController = PostParkingController(nibName: "PostParkingController", bundle: nil)
            self.navigationController?.pushViewController(postParkingController, animated: true)
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            authService.logOut()
            let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let loginController = LoginController(nibName: "LoginController", bundle: nil)
            delegate.window?.rootViewController = loginController
            delegate.window?.makeKeyAndVisible()
            break
        default:
            break
        }
        
    }
}


extension ProfileAdapter: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileDataManager.ProfileItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = indexPath.row
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = ProfileDataManager.ProfileItems[row]
        cell.targetForAction(#selector(ProfileController.cellClickEvent), withSender: cell)
        return cell
    }
    
    func cellClickEvent(sender: ExtendedCell) {
        let row = sender.rowIndex()
        print("click: \(row)")
    }
}