//
//  AWSClient.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/22/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import AWSS3

class AWSClient {
    
    var uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    var downloadRequests = Array<AWSS3TransferManagerDownloadRequest?>()
    
    var uploadFileURLs = Array<NSURL?>()
    var downloadFileURLs = Array<NSURL?>()
    
    init() {
        FileUtils.createTemporaryDirectoryWithName("upload")
        FileUtils.createTemporaryDirectoryWithName("download")
    }
    
    // MARK: prepare for upload image.
    func prepareUploadImage(user: String!, image: UIImage) -> (AWSS3TransferManagerUploadRequest, NSURL){
        // get data and compress from image
        let imageData = UIImageJPEGRepresentation(image, 0.8);
        
        // get file. and write to file. we just can send to amazon when having file url
        // let fileName = NSProcessInfo.processInfo().globallyUniqueString.stringByAppendingString(".jpeg")
        let fileName = imageData?.MD5().stringByAppendingString(".jpeg")
        let fileURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload").URLByAppendingPathComponent(fileName!)
        let filePath = fileURL.path!
        
        // start to write image into disk
        imageData!.writeToFile(filePath, atomically: true)
        
        // create upload request for AWS
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        // make it public. so anyone can use this links
        uploadRequest.ACL = AWSS3ObjectCannedACL.PublicRead
        uploadRequest.body = fileURL
        uploadRequest.contentType = "image/jpeg"
        uploadRequest.key = user + "/" + fileName!
        uploadRequest.bucket = Constants.AWS.S3BucketName
       
        return (uploadRequest, fileURL)
    }

    // MARK: upload image to Amazon S3 service
    func uploadImage(user: String!, image: UIImage, success: (String -> Void)?, error: (Void -> Void)?, progress: (Int -> Void)?) {
        let (uploadRequest, _) = prepareUploadImage(user, image: image)
        // upload this request
        upload(uploadRequest, success: success, error: error, progress: progress)
    }
   
    // MARK: add image request to queue for later download
    func prepareImageRequest(user: String!, image: UIImage) {
        let (uploadRequest, fileURL) = prepareUploadImage(user, image: image)
        uploadRequests.append(uploadRequest)
        uploadFileURLs.append(fileURL)
    }
    
    // MARK: upload a single request to Amazon S3 service
    func upload(uploadRequest: AWSS3TransferManagerUploadRequest, success: (String -> Void)?, error: (Void -> Void)?, progress: (Int -> Void)?) {
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        
        // NSNotificationCenter.defaultCenter().postNotificationName(EventSignal.UploadStartEvent, object:
        
        // set upload request progress callback
        uploadRequest.uploadProgress = {
            (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if totalBytesExpectedToSend > 0 {
                    if (totalBytesSent == totalBytesExpectedToSend) {
                        print("Upload finish")
                    } else {
                        let percent = Int(Double(totalBytesSent) / Double(totalBytesExpectedToSend) * 100)
                        let userInfo : [String:Int] = ["percent": percent]
                        NSNotificationCenter.defaultCenter().postNotificationName(EventSignal.UploadProgressEvent, object: nil, userInfo: userInfo)
                        progress?(percent)
                    }
                }
            })
        }
       
        // callback for upload result
        transferManager.upload(uploadRequest).continueWithBlock {
            (task) -> AnyObject! in
            if let error = task.error {
                if error.domain == AWSS3TransferManagerErrorDomain as String {
                    if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
                        switch (errorCode) {
                        case .Cancelled, .Paused:
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                print("Upload is canceled or paused")
                            })
                            break;
                            
                        default:
                            print("upload() failed: [\(error)]")
                            break;
                        }
                    } else {
                        print("upload() failed: [\(error)]")
                    }
                } else {
                    print("upload() failed: [\(error)]")
                }
            }
            
            if let exception = task.exception {
                print("upload() failed: [\(exception)]")
            }
            
            if task.result != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    () -> Void in
                    let url = Constants.AWS.AWS_DOMAIN + uploadRequest.key!
                    let userInfo : [String:String] = ["server_url": url]
                    NSNotificationCenter.defaultCenter().postNotificationName(EventSignal.UploadDoneEvent, object: nil, userInfo: userInfo)
                    success?(url)
                })
            } else {
                print("shit")
            }
            
            return nil
        }
    }
    
    // MARK: Download single request
    func download(downloadRequest: AWSS3TransferManagerDownloadRequest, success: Void -> Void, error: Void -> Void) {
        switch (downloadRequest.state) {
        case .NotStarted, .Paused:
            // get default transfer manager
            let transferManager = AWSS3TransferManager.defaultS3TransferManager()
            
            transferManager.download(downloadRequest).continueWithBlock({
                (task) -> AnyObject! in
                // handle exception
                if let error = task.error {
                    if error.domain == AWSS3TransferManagerErrorDomain as String
                        && AWSS3TransferManagerErrorType(rawValue: error.code) == AWSS3TransferManagerErrorType.Paused {
                        print("Download paused.")
                    } else {
                        print("download failed: [\(error)]")
                    }
                } else if let exception = task.exception {
                    print("download failed: [\(exception)]")
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        success()
                    })
                }
                return nil
            })
            
            break
        default:
            break
        }
    }
   
    // MARK: Download all files
    func downloadAll(success: Void -> Void, error: Void -> Void) {
        for (_, value) in self.downloadRequests.enumerate() {
            if let downloadRequest = value {
                if downloadRequest.state == .NotStarted || downloadRequest.state == .Paused {
                    self.download(downloadRequest, success: success, error: error)
                }
            }
        }
    }
    
    // MARK: Upload all files
    func uploadAll() {
        for (index, value) in self.uploadRequests.enumerate() {
            if let uploadRequest = value {
                if uploadRequest.state == .NotStarted || uploadRequest.state == .Paused {
                    self.upload(uploadRequest,
                        success: { (fileUrl) in
                            self.uploadFileURLs[index] = nil
                            self.uploadRequests[index] = nil
                        }, error: { (Void) in
                            // currently do nothing here
                        }, progress: { (progress) in
                            // currently do nothing here
                    })
                }
            }
        }
    }
    
    
    func cancelAllUploads() {
        for (_, uploadRequest) in self.uploadRequests.enumerate() {
            if let uploadRequest = uploadRequest {
                uploadRequest.cancel().continueWithBlock({ (task) -> AnyObject! in
                    if let error = task.error {
                        print("cancel() failed: [\(error)]")
                    }
                    if let exception = task.exception {
                        print("cancel() failed: [\(exception)]")
                    }
                    return nil
                })
            }
        }
    }
    
    // MARK: Cancel all downloads in queue
    func cancelAllDownloads() {
        for (_, value) in self.downloadRequests.enumerate() {
            if let downloadRequest = value {
                if downloadRequest.state == .Running || downloadRequest.state == .Paused {
                    downloadRequest.cancel().continueWithBlock({
                        (task) -> AnyObject! in
                        if let error = task.error {
                            print("cancel() failed: [\(error)]")
                        } else if let exception = task.exception {
                            print("cancel() failed: [\(exception)]")
                        }
                        return nil
                    })
                }
            }
        }
    }
    
    
    // MARK: get download index in queue
    func indexOfDownloadRequest(downloadRequest: AWSS3TransferManagerDownloadRequest?) -> Int? {
        for (index, object) in downloadRequests.enumerate() {
            if object == downloadRequest {
                return index
            }
        }
        return nil
    }
    
    // MARK: get upload index in queue
    func indexOfUploadRequest(uploadRequest: AWSS3TransferManagerUploadRequest?) -> Int? {
        for (index, object) in uploadRequests.enumerate() {
            if object == uploadRequest {
                return index
            }
        }
        return nil
    }
}