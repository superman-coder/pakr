//
// Created by Huynh Quang Thao on 4/9/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class PakrTabBarController: UIKit.UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // set up all view controllers for tab bar
        
        var viewControllers: [UIViewController] = []
        
        var navController: UINavigationController!
        
        navController = UINavigationController()
        let mapController = MapController(nibName: "MapController", bundle: nil)
        let mapItem = UITabBarItem(title: "NearBy", image: UIImage(named: "nearby.png"), tag: 0)
        mapController.tabBarItem = mapItem
        navController.viewControllers = [mapController]
        viewControllers.append(navController)
        
        navController = UINavigationController()
        let listParkingController = SearchController(nibName: "SearchController", bundle: nil)
        let listItem = UITabBarItem(title: "Search", image: UIImage(named: "search.png"), tag: 1)
        listParkingController.tabBarItem = listItem
        navController.viewControllers = [listParkingController]
        viewControllers.append(navController)
        
        navController = UINavigationController()
        let bookmarkController = BookmarkController(nibName: "BookmarkController", bundle: nil)
        let bookmarkItem = UITabBarItem(title: "Bookmark", image: UIImage(named: "favorite.png"), tag: 2)
        bookmarkController.tabBarItem = bookmarkItem
        navController.viewControllers = [bookmarkController]
        viewControllers.append(navController)
        
        navController = UINavigationController()
        let profileController = ProfileController(nibName: "ProfileController", bundle: nil)
        let profileItem = UITabBarItem(title: "More", image: UIImage(named: "more.png"), tag: 3)
        profileController.tabBarItem = profileItem
        navController.viewControllers = [profileController]
        viewControllers.append(navController)
        
        self.viewControllers = viewControllers
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}

//MARK UITabBarController Delegate
extension PakrTabBarController: UITabBarControllerDelegate {
    
}