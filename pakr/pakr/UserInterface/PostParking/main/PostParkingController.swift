//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import AYStepperView
import MBXPageViewController
import Bolts
import Parse

class PostParkingController: BaseViewController {
    
    var pageController: MBXPageViewController!
    var postInfoController: PostInfoController!
    var mapImageController: SelectMapImageController!
    var verifyController: VerifyController!
    
    var authService: AuthService!
    var awsClient: AWSClient!
    
    @IBOutlet weak var stepViewContainer: UIView!
    var stepView: AYStepperView!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = WebServiceFactory.getAuthService()
        awsClient = AWSClient()
        
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
            titles: ["Step 1", "Step 2", "Step 3"])
        stepView.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        stepView.userInteractionEnabled = true
        stepViewContainer.addSubview(stepView)
    }
    
    func setUpPageView() {
        postInfoController = PostInfoController(nibName: "PostInfoController", bundle: nil)
        postInfoController.delegate = self
        mapImageController = SelectMapImageController(nibName: "SelectMapImageController", bundle: nil)
        mapImageController.postParkingController = self
        verifyController = VerifyController(nibName: "VerifyController", bundle: nil)
        verifyController.postParkingController = self
        
        pageController = MBXPageViewController()
        pageController.MBXDataSource = self
        pageController.MBXDataDelegate = self
        pageController.reloadPages()
        for view in self.pageController.view.subviews{
      let scroll = view as! UIScrollView
            if scroll .isKindOfClass(UIScrollView){
                scroll.scrollEnabled = false
            }
        }
    }
    
    var count = 0
    var arrImages: [UIImage]!
    
    func startEvent(notification: NSNotification) {
        
    }
    
    func progressEvent(notification: NSNotification) {
        print("hahaha")
        let progress = notification.valueForKey(EventSignal.UploadProgressEvent)
        print("hahaha. \(progress)")
    }
    
    func doneEvent(notification: NSNotification) {
        count = count + 1
        if count < arrImages.count {
            print("start to download image \(count)")
            awsClient.uploadImage(authService.getLoginUser()?.email, image: arrImages[count], success: nil, error: nil, progress: nil)
        } else {
            print("Download all finish :D")
        }
    }
    
    func onSwitchScreen(sender: UIButton) {
//        print("click")
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
       navigationController?.popViewControllerAnimated(true)
    }
    
    func uploadAllImages() {
        
    }
   
    var uploadManager: UploadManager!
    
    func upLoadParking() {
        var arrImages : [UIImage] = []
        
        // 1. upload cover images
        arrImages.append(mapImageController.imageCover)
        
        // 2. upload all images
        arrImages.appendContentsOf(mapImageController.arrImageParking?.copy() as! [UIImage])
        
        
        // --- create a parking ---
        
        // create business
        let business = Business(businessName: postInfoController.businessNameTextField.text, businessDescription: postInfoController.businessDescriptionTextField.text, telephone: postInfoController.businessTelephoneTextField.text)
        
        // create all vehicle detail
        var vehicleDetails : [VehicleDetail] = []
        if (postInfoController.bikeCheckBox.on) {
            let bikeDetail = VehicleDetail(vehicleType: VehicleType.Bike, minPrice: postInfoController.bikeMinPriceTextField.text, maxPrice: postInfoController.bikeMaxPriceTextField.text, note: "")
            vehicleDetails.append(bikeDetail)
        }
        
        if (postInfoController.motorCheckBox.on) {
            let motorDetail = VehicleDetail(vehicleType: VehicleType.Motor, minPrice: postInfoController.motorMinPriceTextField.text, maxPrice: postInfoController.motorMaxPriceTextField.text, note: "")
            vehicleDetails.append(motorDetail)
        }
        if (postInfoController.carCheckBox.on) {
            let carDetail = VehicleDetail(vehicleType: VehicleType.Car, minPrice: postInfoController.carMinPriceTextField.text, maxPrice: postInfoController.carMaxPriceTextField.text, note: "")
            vehicleDetails.append(carDetail)
        }

        // create time range
        let timeRange = postInfoController.arrTimeRange.copy() as! [TimeRange]
        
        let parking = Parking(business: business, parkingName: postInfoController.parkingNameTextField.text, capacity: 20, addressName: postInfoController.parkingAddressTextField.text!, coordinate: mapImageController.parkingLocation!.coordinate(), vehicleDetailList: vehicleDetails, schedule: timeRange, region: [])
        
        let topic = Topic(userId: authService.getLoginUser()?.userId, parking: parking, rating: 0)
  
        // start uploading data
        uploadManager = UploadManager(topic: topic, arrImages: arrImages, delegate: verifyController)
        uploadManager.startUpload()
    }
  
    
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
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
//        print("click \(index)")
        self.stepView.userInteractionEnabled = false
        self.stepView.updateCurrentStepIndex(UInt(index), completionBlock: {
            Void -> Void in
            self.stepView.userInteractionEnabled = true
        })
    }
}

extension PostParkingController: PostInfoControllerDelegate{
    func nextStep(parking: Parking) {
        self.mapImageController.parking = parking
    }
}

//delegate PostParkingDelegate {
//    func startUploadImage(imageUrl: String)
//    func uploadImageProgress(progress: Int)
//}