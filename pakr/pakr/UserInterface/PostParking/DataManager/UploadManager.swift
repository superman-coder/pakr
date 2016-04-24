//
//  DownloadManager.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/24/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

class UploadManager: NSObject {
    
    var count = 0
    var arrImages: [UIImage]!
    var serverImageUrls: [String] = []
    var  awsClient: AWSClient
    let  authService: AuthService
    var topic: Topic!
    var delegate: UploadManagerDelegate!
    
    init(topic: Topic, arrImages: [UIImage], delegate: UploadManagerDelegate) {
        awsClient = AWSClient()
        authService = WebServiceFactory.getAuthService()
        
        self.topic = topic
        self.arrImages = arrImages
        self.delegate = delegate
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UploadManager.startEvent(_:)), name: EventSignal.UploadStartEvent, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UploadManager.progressEvent(_:)), name: EventSignal.UploadProgressEvent, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UploadManager.doneEvent(_:)), name: EventSignal.UploadDoneEvent, object: nil)
    }
    
    func startEvent(notification: NSNotification) {
    }
    
    func progressEvent(notification: NSNotification) {
        //let progress = notification.valueForKey(EventSignal.UploadProgressEvent)
        
    }
    
    func doneEvent(notification: NSNotification) {
        let imageUrl = notification.userInfo!["server_url"] as! String
        serverImageUrls.append(imageUrl)
        
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
                    print("\(error!.localizedDescription)")
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
                    print("\(error!.localizedDescription)")
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
