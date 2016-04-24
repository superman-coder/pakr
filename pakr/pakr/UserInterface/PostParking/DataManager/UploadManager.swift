//
//  DownloadManager.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/24/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

class UploadManager {
    
    var count = 0
    var arrImages: [UIImage]!
    var serverImageUrls: [String] = []
    let  awsClient: AWSClient
    let  authService: AuthService
    var topic: Topic!
    var delegate: UploadManagerDelegate!
    
    init(topic: Topic, arrImages: [UIImage], delegate: UploadManagerDelegate) {
        self.topic = topic
        self.arrImages = arrImages
        self.delegate = delegate
        
        awsClient = AWSClient()
        authService = WebServiceFactory.getAuthService()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostParkingController.startEvent(_:)), name: EventSignal.UploadStartEvent, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostParkingController.progressEvent(_:)), name: EventSignal.UploadProgressEvent, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostParkingController.doneEvent(_:)), name: EventSignal.UploadDoneEvent, object: nil)
    }
    
    func startEvent(notification: NSNotification) {
    }
    
    func progressEvent(notification: NSNotification) {
        let progress = notification.valueForKey(EventSignal.UploadProgressEvent)
        
    }
    
    func doneEvent(notification: NSNotification) {
        let imagUrl = notification.valueForKey(EventSignal.UploadDoneEvent) as! String
        serverImageUrls.append(imagUrl)
        
        count = count + 1
        if count < arrImages.count {
            print("start to download image \(count)")
            awsClient.uploadImage(authService.getLoginUser()?.email, image: arrImages[count], success: nil, error: nil, progress: nil)
        } else {
            print("Download all finish :D")
            
            // continue to download topic
            topic.parking.imageUrl = serverImageUrls
            topic.toPFObject().saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("UPLOAD ALL FINISH")
                } else {
                }
            }
        }
    }
    
    func startUpload() {
        if (arrImages.count > 0) {
            awsClient.uploadImage(authService.getLoginUser()?.email, image: arrImages[0], success: nil, error: nil, progress: nil)
        } else {
            print("Upload without image :-O")
            topic.toPFObject().saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("UPLOAD ALL FINISH")
                } else {
                    // There was a problem, check error.description
                }
            }
        }
    }
    
    func uploadTopic() {
        
    }
    
    func updateUI2(serverUrl: String, index: Int) {
        
    }
    func updateUI(progress: Int) {
        
    }
    
}

protocol UploadManagerDelegate {
}
