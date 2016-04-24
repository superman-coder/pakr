//
// Created by Huynh Quang Thao on 4/11/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class VerifyController: BaseViewController {

    @IBOutlet weak var uploadStatusTextView: UILabel!
    
    @IBOutlet weak var progressStatusTextView: UILabel!
    
    @IBOutlet weak var imageStatusTextView: UIImageView!
    
    @IBOutlet weak var controlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        progressStatusTextView.text = "0%"
        progressStatusTextView.hidden = true
        uploadStatusTextView.text = "Upload your parking to the world"
    }
    
    @IBAction func postParkingEvent(sender: AnyObject) {
        // this version doesn't allow user cancel uploading
        controlButton.enabled = false
        
        // 1. upload cover images
        
        // 2. upload all images
        
        // 3. upload all datas
    
        // 4. back to normal state
        controlButton.enabled = true
        uploadStatusTextView.text = "Finish"
    }
}
