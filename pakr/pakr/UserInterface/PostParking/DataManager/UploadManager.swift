//
//  DownloadManager.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/24/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class UploadManager {
    
    var count = 0
    var arrImages: [UIImage]
    let  awsClient: AWSClient
    let  authService: AuthService
    var topic: Topic!
    var arrImages: [UIImage]
    
    init(topic: Topic) {
        self.topic = topic
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
        count = count + 1
        if count < arrImages.count {
            print("start to download image \(count)")
            awsClient.uploadImage(authService.getLoginUser()?.email, image: arrImages[count], success: nil, error: nil, progress: nil)
        } else {
            print("Download all finish :D")
        }
    }
    
    func startUpload() {
    }
    
    func uploadTopic() {
        
    }
    
    func updateUI2(serverUrl: String, index: Int) {
        
    }
    func updateUI(progress: Int) {
        
    }
}