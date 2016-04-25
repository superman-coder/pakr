//
// Created by Huynh Quang Thao on 4/11/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class VerifyController: BaseViewController {

    @IBOutlet weak var uploadStatusTextView: UILabel!
    
    @IBOutlet weak var progressStatusTextView: UILabel!
    
    @IBOutlet weak var controlButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var imageStatusView: UIImageView!
    
    var postParkingController : PostParkingController!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        controlButton.layer.cornerRadius = 20
        controlButton.layer.borderColor = UIColor.UIColorFromRGB(Constants.Color.PrimaryColor).CGColor
        controlButton.layer.borderWidth=2.0;
        
        progressStatusTextView.text = "0%"
        progressStatusTextView.hidden = true
        progressBar.progress = 0
        uploadStatusTextView.text = "Upload your parking to the world"
    }
    
    @IBAction func postParkingEvent(sender: AnyObject) {
        //controlButton.enabled = false
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
            imageStatusView.image = postParkingController.getImageByOrder(order)
            break
        // all sub images
        default:
           uploadStatusTextView.text = "Saving photos ...."
           imageStatusView.image = postParkingController.getImageByOrder(order)
            break
        }
    }
    
    func uploadProgress(order: Int, progress: Int, progressAll: Int) {
        if imageStatusView.image != nil {
            imageStatusView.alpha = CGFloat(progress / 100)
        }
        progressBar.progress = Float( progressAll / 100)
        progressStatusTextView.text = "\(progressAll) %"
    }
    
    func doneUploadTopic(topic: Topic) {
        uploadStatusTextView.text = "Finish :D :D :D"
    }
}