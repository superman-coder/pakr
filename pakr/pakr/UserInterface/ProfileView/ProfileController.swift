//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
    @IBOutlet weak var profileImageView: CircularImageView!
    @IBOutlet weak var fullNameTextView: UILabel!
    @IBOutlet weak var userNameTextView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var webService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webService = WebServiceFactory.getAuthService()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        if (row == 5) {
            webService.logOut()
            let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let loginController = LoginController(nibName: "LoginController", bundle: nil)
            delegate.window?.rootViewController = loginController
            delegate.window?.makeKeyAndVisible()
        }
    }
}


extension ProfileController: UITableViewDataSource {
    
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