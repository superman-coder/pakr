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
    
    var order = 0
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
        let progress = notification.userInfo!["percent"] as! Int
        delegate.uploadProgress(order, progress: progress,
                                progressAll: calcProgressAll(progress, order: order))
    }
    
    func calcProgressAll(progress: Int, order: Int) -> Int {
        let totalPart = arrImages.count + 1
        return  progress / totalPart + (order / totalPart) * 100
    }
    
    func doneEvent(notification: NSNotification) {
        let imageUrl = notification.userInfo!["server_url"] as! String
        serverImageUrls.append(imageUrl)
        
       order = order + 1
        if order < arrImages.count {
            print("start to upload image \(order)")
            delegate.startUpload(order)
            awsClient.uploadImage(authService.getLoginUser()?.email, image: arrImages[order], success: nil, error: nil, progress: nil)
        } else {
            print("Upload all images finish :D")
            
            // continue to download topic
            delegate.startUpload(-1)
            // assign all uploaded url to topic again
            topic.parking.imageUrl = serverImageUrls
            WebServiceFactory.getAddressService().postTopic(topic, complete: { (topic, error) in
                if error != nil {
                     print("\(error!.localizedDescription)")
                }else{
                    self.delegate.doneUploadTopic(topic!)
                }
            })
        }
    }
    
    func startUpload() {
        print("UPLoad___________________________________")
        if arrImages.count > 0 {
            delegate.startUpload(order)
            awsClient.uploadImage(authService.getLoginUser()?.email, image: arrImages[0], success: nil, error: nil, progress: nil)
        } else {
            print("Upload without image. Maybe for testing only :-O")
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
}

protocol UploadManagerDelegate {
    func startUpload(order: Int)
    func uploadProgress(order: Int, progress: Int, progressAll: Int)
    func doneUploadTopic(topic: Topic)
}
