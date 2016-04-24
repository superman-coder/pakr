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
    var mapImageController: SelectMapImageController!
    var verifyController: BaseViewController!
    
    @IBOutlet weak var stepViewContainer: UIView!
    var stepView: AYStepperView!
    
    var arrStepButton: NSArray!
    var currentIndex: Int = 0
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpStepView()
        setUpPageView()
    }
    
//MARK - Private Method

    func setUpNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(PostParkingController.onCreateParkingLot))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(PostParkingController.onCancelCreate))
        self.navigationItem.title = "Create Parking Lot"
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func setUpStepView() {
        stepView = AYStepperView(
            frame: stepViewContainer.bounds,
            titles: ["Step 1", "Step 2", "Step 3", ""])
        stepView.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        stepView.userInteractionEnabled = true
        stepViewContainer.addSubview(stepView)
        arrStepButton = self.stepView.stepButtons
        
        for button in arrStepButton {
           let  buttonStep =  button as! UIButton
            buttonStep.tag = arrStepButton.indexOfObject(button)
            buttonStep.addTarget(self, action: #selector(PostParkingController.touchUpInSideStepButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func touchUpInSideStepButton(sender: UIButton){
        if sender.tag < currentIndex {
            updateData(sender.tag)
        }else if sender.tag > currentIndex {
            switch sender.tag {
            case postInfoController.value:
                if postInfoController.isNextStep() == true {
                    updateData(sender.tag)
                }
                break
            case mapImageController.value:
                if mapImageController.isNextStep() == true {
                    updateData(sender.tag)
                }
                break
            default:
                break
            }
        }
    }
    
    func updateData(index: Int){
        currentIndex = index
        updateStepViewToIndex(index)
        updatePageControl(index)
    }
    
    func updateStepViewToIndex(index: Int) {
        if index ==  2 {
            self.stepView.userInteractionEnabled = false
            self.stepView.updateCurrentStepIndex(3, completionBlock: {
                Void -> Void in
                self.stepView.userInteractionEnabled = true
            })
        }else{
            self.stepView.userInteractionEnabled = false
            self.stepView.updateCurrentStepIndex(UInt(index), completionBlock: {
                Void -> Void in
                self.stepView.userInteractionEnabled = true
            })
        }
    }
    
    func updatePageControl(index: Int){
        pageController.reloadPagesToCurrentPageIndex(index)
    }
    func setUpPageView() {
        postInfoController = PostInfoController(nibName: "PostInfoController", bundle: nil)
        postInfoController.delegate = self
        mapImageController = SelectMapImageController(nibName: "SelectMapImageController", bundle: nil)
        mapImageController.postParkingController = self
        verifyController = VerifyController(nibName: "VerifyController", bundle: nil)
        
        pageController = MBXPageViewController()
        pageController.MBXDataSource = self
        pageController.reloadPages()
        for view in self.pageController.view.subviews{
      let scroll = view as! UIScrollView
            if scroll .isKindOfClass(UIScrollView){
                scroll.scrollEnabled = false
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func onCreateParkingLot(sender: AnyObject) {
        
    }
    
    func onCancelCreate(sender: AnyObject) {
       navigationController?.popViewControllerAnimated(true)
    }
    
    func uploadAllImages() {
        
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension PostParkingController: MBXPageControllerDataSource {
    func MBXPageButtons() -> [AnyObject]! {
        return [UIButton()]
    }
    
    func MBXPageControllers() -> [AnyObject]! {
        return [postInfoController, mapImageController, verifyController]
    }
    
    func MBXPageContainer() -> UIView! {
        return self.containerView
    }
}


extension PostParkingController: PostInfoControllerDelegate{
    func nextStep(parking: Parking) {
        self.mapImageController.parking = parking
    }
}