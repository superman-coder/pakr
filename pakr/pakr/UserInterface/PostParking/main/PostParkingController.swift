//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import AYStepperView
import MBXPageViewController

class PostParkingController: BaseViewController {
    
    var pageController: MBXPageViewController!
    var postInfoController: PostInfoController!
    var mapImageController: BaseViewController!
    var verifyController: BaseViewController!
    
    @IBOutlet weak var stepViewContainer: UIView!
    var stepView: AYStepperView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpPageView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpStepView()
        pageController.reloadPagesToCurrentPageIndex(0)
    }
    
    func setUpNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(PostParkingController.onCreateParkingLot))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(PostParkingController.onCancelCreate))
        self.navigationItem.title = "Create Parking Lot"
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func setUpStepView() {
        stepView = AYStepperView(
            frame: stepViewContainer.bounds,
            titles: ["Step 1", "Step 2", "Step 3"])
        stepView.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        stepView.userInteractionEnabled = true
        stepViewContainer.addSubview(stepView)

        // we use PageViewController. so don't need to add callback manually again  
//        for i in 0 ..< stepView.stepButtons.count {
//            let button = stepView.stepButtons[i] as! UIButton
//            button.tag = i
//            button.addTarget(self, action: #selector(PostParkingController.onSwitchScreen), forControlEvents: UIControlEvents.TouchUpInside)
//        }
//        
    }
    
    func setUpPageView() {
        postInfoController = PostInfoController(nibName: "PostInfoController", bundle: nil)
        mapImageController = SelectMapImageController(nibName: "SelectMapImageController", bundle: nil)
        verifyController = VerifyController(nibName: "VerifyController", bundle: nil)
        
        pageController = MBXPageViewController()
        pageController.MBXDataSource = self
        pageController.MBXDataDelegate = self
    }
    
    func onSwitchScreen(sender: UIButton) {
        print("click")
        let position = sender.tag
        stepView.updateCurrentStepIndex(UInt(position), completionBlock: {
            Void -> Void in
        })
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func onCreateParkingLot(sender: AnyObject) {
        
    }
    
    func onCancelCreate(sender: AnyObject) {
        
    }
}

extension PostParkingController: MBXPageControllerDataSource {
    func MBXPageButtons() -> [AnyObject]! {
        return self.stepView.stepButtons as NSArray as [AnyObject]
    }
    
    func MBXPageControllers() -> [AnyObject]! {
        return [postInfoController, mapImageController, verifyController]
    }
    
    func MBXPageContainer() -> UIView! {
        return self.containerView
    }
}

extension PostParkingController: MBXPageControllerDataDelegate {
    func MBXPageChangedToIndex(index: Int) {
        self.stepView.userInteractionEnabled = false
        self.stepView.updateCurrentStepIndex(UInt(index), completionBlock: {
            Void -> Void in
            self.stepView.userInteractionEnabled = true
        })
    }
}