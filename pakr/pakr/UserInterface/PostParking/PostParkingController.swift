//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import AYStepperView

class PostParkingController: BaseViewController {

    @IBOutlet weak var stepViewContainer: UIView!
    var stepperView: AYStepperView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Create Parking Lot"
        self.view.backgroundColor = UIColor.whiteColor()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(PostParkingController.onCreateParkingLot))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(PostParkingController.onCancelCreate))

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stepperView = AYStepperView(
                frame: stepViewContainer.bounds,
                titles: ["Step 1", "Step 2", "Step 3", "Step 4", "Step 5", "Step 6"])
        stepperView.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        stepperView.userInteractionEnabled = true
       stepViewContainer.addSubview(stepperView)
        
        for i in 0 ..< stepperView.stepButtons.count {
            let button = stepperView.stepButtons[i] as! UIButton
            button.tag = i
            button.addTarget(self, action: #selector(PostParkingController.onSwitchScreen), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func onSwitchScreen(sender: UIButton) {
        let position = sender.tag
        stepperView.updateCurrentStepIndex(UInt(position), completionBlock: {
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