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
    }
    
    override func viewWillAppear(animated: Bool) {
          // set up all view controllers for tab bar

        var viewControllers: [UIViewController] = []

//        let navController = UIKit.UINavigationController()
//        let postController = PostInfoController(nibName: "PostInfoController", bundle: nil)
//        let postItem = UITabBarItem(title: "Post", image: UIImage(named: "nearby.png"), tag: 0)
//        postController.tabBarItem = postItem
//        navController.viewControllers = [postController]
//        viewControllers.append(navController)

        var navController: UINavigationController!
        
        navController = UINavigationController()
        let postController = PostParkingController(nibName: "PostParkingController", bundle: nil)
        let postItem = UITabBarItem(title: "Post", image: UIImage(named: "nearby.png"), tag: 0)
        postController.tabBarItem = postItem
        navController.viewControllers = [postController]
        viewControllers.append(navController)

        let mapController = MapController(nibName: "MapController", bundle: nil)
        let mapItem = UITabBarItem(title: "NearBy", image: UIImage(named: "nearby.png"), tag: 0)
        mapController.tabBarItem = mapItem
        viewControllers.append(mapController)

        navController = UINavigationController()
        let listParkingController = ParkingListController(nibName: "ParkingListController", bundle: nil)
        let listItem = UITabBarItem(title: "Search", image: UIImage(named: "search.png"), tag: 1)
        listParkingController.tabBarItem = listItem
        navController.viewControllers = [listParkingController]
        viewControllers.append(navController)
        
        let bookmarkController = BookmarkController(nibName: "BookmarkController", bundle: nil)
        let bookmarkItem = UITabBarItem(title: "Bookmark", image: UIImage(named: "favorite.png"), tag: 2)
        bookmarkController.tabBarItem = bookmarkItem
        viewControllers.append(bookmarkController)
        
        let profileController = ProfileController(nibName: "ProfileController", bundle: nil)
        let profileItem = UITabBarItem(title: "More", image: UIImage(named: "more.png"), tag: 3)
        profileController.tabBarItem = profileItem
        viewControllers.append(profileController)
        
        self.viewControllers = viewControllers
    }
}

//MARK UITabBarController Delegate
extension PakrTabBarController: UITabBarControllerDelegate {
    
}