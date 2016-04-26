//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking
class ProfileController: BaseViewController {
    @IBOutlet weak var profileImageView: CircularImageView!
    @IBOutlet weak var fullNameTextView: UILabel!
    @IBOutlet weak var userNameTextView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MORE"
        authService = WebServiceFactory.getAuthService()
        let currentUser = authService.getLoginUser()
        if let currentUser = currentUser {
            if let avatar = currentUser.avatarUrl {
               self.profileImageView.setImageWithURL(NSURL(string: avatar)!, placeholderImage: nil)
            }
        }
        
        
        userNameTextView.text = authService.getLoginUser()?.email
        fullNameTextView.text = authService.getLoginUser()?.name
       
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        switch row {
        case 0:
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
        case 6:
            self.navigationController?.pushViewController(AllPostParkingTableViewController(), animated: true)
            break
        default:
            break
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