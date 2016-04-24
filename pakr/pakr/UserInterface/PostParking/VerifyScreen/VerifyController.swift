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
    
    var postParkingController : PostParkingController!
   
    var awsClient = AWSClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        progressStatusTextView.text = "0%"
        progressStatusTextView.hidden = true
        uploadStatusTextView.text = "Upload your parking to the world"
    }
    
    @IBAction func postParkingEvent(sender: AnyObject) {
        controlButton.enabled = false
        postParkingController.upLoadParking()
    }
}

extension VerifyController: UploadManagerDelegate {
    
    func startUpload(order: Int) {
        switch order {
        // start upload topic
        case -1:
            uploadStatusTextView.text = "Saving parking ..."
            break
        // start upload cover
        case 0:
            uploadStatusTextView.text = "Saving cover photos ..."
            break
        // all sub images
        default:
           uploadStatusTextView.text = "Saving photos ...."
            break
        }
    }
    
    func uploadProgress(order: Int, progress: Int) {
        
    }
    
    func doneUploadTopic(topic: Topic) {
       uploadStatusTextView.text = "Finish :D :D :D"
        controlButton.enabled = true
    }
}