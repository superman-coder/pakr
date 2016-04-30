//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking
class ProfileController: BaseViewController, ProfileView {
    @IBOutlet weak var profileImageView: CircularImageView!
    @IBOutlet weak var fullNameTextView: UILabel!
    @IBOutlet weak var userNameTextView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileHeaderView: UIView!
    
   var presenter: ProfilePresenter!
    
   var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = ProfileDataModelImpl()
        let router = ProfileRouterImpl(screen: self)
        let tracker = ProfileTrackerImpl()
        let profileAdapter = ProfileAdapterImpl(tableView: tableView, model: model)
        presenter = ProfilePresenterImpl(view: self, model: model,
                                         router: router, tracker: tracker, adapter: profileAdapter)
        
        presenter.initView()
    }
    
    func initView() {
        self.title = "MORE"
        self.view.backgroundColor = UIColor.UIColorFromRGB(0xE0E0E0)
        
        LayoutUtils.dropShadowView(profileHeaderView)
        
        userNameTextView.text = presenter.getHeaderUser().email
        fullNameTextView.text = presenter.getHeaderUser().name
        profileImageView.setImageWithURL(NSURL(string: presenter.getHeaderUser().avatarUrl!)!)
    }
}

