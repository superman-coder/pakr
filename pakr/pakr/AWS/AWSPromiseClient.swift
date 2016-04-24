////
////  AWSClient.swift
////  pakr
////
////  Created by Huynh Quang Thao on 4/22/16.
////  Copyright © 2016 Pakr. All rights reserved.
////
//
//import Foundation
//import AWSS3
//import PromiseKit
//
//class AWSPromiseClient {
//    
//    init() {
//        FileUtils.createTemporaryDirectoryWithName("upload")
//        FileUtils.createTemporaryDirectoryWithName("download")
//    }
//    
//    func uploadImage(user: String!, image: UIImage) -> Promise<String> {
//        return Promise<String> { fulfill, reject in
//            let transferManager = AWSS3TransferManager.defaultS3TransferManager()
//            
//            // get data and compress from image
//            let imageData = UIImageJPEGRepresentation(image, 0.9);
//            
//            // get file. and write to file. we just can send to amazon when having file url
//            // let fileName = NSProcessInfo.processInfo().globallyUniqueString.stringByAppendingString(".jpeg")
//            let fileName = imageData?.MD5().stringByAppendingString(".jpeg")
//            let fileURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload").URLByAppendingPathComponent(fileName!)
//            let filePath = fileURL.path!
//            
//            // start to write image into disk
//            imageData!.writeToFile(filePath, atomically: true)
//            
//            // create upload request for AWS
//            let uploadRequest = AWSS3TransferManagerUploadRequest()
//            // make it public. so anyone can use this links
//            uploadRequest.ACL = AWSS3ObjectCannedACL.PublicRead
//            uploadRequest.body = fileURL
//            uploadRequest.contentType = "image/jpeg"
//            uploadRequest.key = user + "/" + fileName!
//            uploadRequest.bucket = Constants.AWS.S3BucketName
//            
//            
//            // set upload request progress callback
//            uploadRequest.uploadProgress = {
//                (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    if totalBytesExpectedToSend > 0 {
//                        if (totalBytesSent == totalBytesExpectedToSend) {
//                            print("Upload finish")
//                        } else {
//                            let percent = Int(Double(totalBytesSent) / Double(totalBytesExpectedToSend) * 100)
//                            print (percent)
//                            //progress(percent)
//                        }
//                    }
//                })
//            }
//            
//            // callback for upload result
//            transferManager.upload(uploadRequest).continueWithBlock {
//                (task) -> AnyObject! in
//                if let error = task.error {
//                    if error.domain == AWSS3TransferManagerErrorDomain as String {
//                        if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
//                            switch (errorCode) {
//                            case .Cancelled, .Paused:
//                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                    print("Upload is canceled or paused")
//                                })
//                                break;
//                                
//                            default:
//                                print("upload() failed: [\(error)]")
//                                break;
//                            }
//                        } else {
//                            print("upload() failed: [\(error)]")
//                        }
//                    } else {
//                        print("upload() failed: [\(error)]")
//                    }
//                    reject(NSError(domain: "Custom Domain", code: 0, userInfo: nil))
//                }
//                
//                if let exception = task.exception {
//                    print("upload() failed: [\(exception)]")
//                    reject(NSError(domain: "Custom Domain", code: 0, userInfo: nil))
//                }
//                
//                
//                if task.result != nil {
//                    fulfill("")
//                }
//                
//                return nil
//            }
//        }
//    }
//    
//    // MARK: upload image to Amazon S3 service
//    func uploadImage(user: String!, image: UIImage, success: String -> Void, error: Void -> Void, progress: Int -> Void) {
//        
//        // get data and compress from image
//        let imageData = UIImageJPEGRepresentation(image, 0.9);
//        
//        // get file. and write to file. we just can send to amazon when having file url
//        // let fileName = NSProcessInfo.processInfo().globallyUniqueString.stringByAppendingString(".jpeg")
//        let fileName = imageData?.MD5().stringByAppendingString(".jpeg")
//        let fileURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload").URLByAppendingPathComponent(fileName!)
//        let filePath = fileURL.path!
//        
//        // start to write image into disk
//        imageData!.writeToFile(filePath, atomically: true)
//        
//        // create upload request for AWS
//        let uploadRequest = AWSS3TransferManagerUploadRequest()
//        // make it public. so anyone can use this links
//        uploadRequest.ACL = AWSS3ObjectCannedACL.PublicRead
//        uploadRequest.body = fileURL
//        uploadRequest.contentType = "image/jpeg"
//        uploadRequest.key = user + "/" + fileName!
//        uploadRequest.bucket = Constants.AWS.S3BucketName
//        
//        // upload this request
//        upload(uploadRequest, success: success, error: error, progress: progress)
//    }
//    
//    // MARK: upload a single request to Amazon S3 service
//    func upload(uploadRequest: AWSS3TransferManagerUploadRequest, success: String -> Void, error: Void -> Void, progress: Int -> Void) {
//        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
//        
//        // set upload request progress callback
//        uploadRequest.uploadProgress = {
//            (bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                if totalBytesExpectedToSend > 0 {
//                    if (totalBytesSent == totalBytesExpectedToSend) {
//                        print("Upload finish")
//                    } else {
//                        let percent = Int(Double(totalBytesSent) / Double(totalBytesExpectedToSend) * 100)
//                        print (percent)
//                        progress(percent)
//                    }
//                }
//            })
//        }
//        
//        // callback for upload result
//        transferManager.upload(uploadRequest).continueWithBlock {
//            (task) -> AnyObject! in
//            if let error = task.error {
//                if error.domain == AWSS3TransferManagerErrorDomain as String {
//                    if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
//                        switch (errorCode) {
//                        case .Cancelled, .Paused:
//                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                print("Upload is canceled or paused")
//                            })
//                            break;
//                            
//                        default:
//                            print("upload() failed: [\(error)]")
//                            break;
//                        }
//                    } else {
//                        print("upload() failed: [\(error)]")
//                    }
//                } else {
//                    print("upload() failed: [\(error)]")
//                }
//            }
//            
//            if let exception = task.exception {
//                print("upload() failed: [\(exception)]")
//            }
//            
//            if task.result != nil {
//                dispatch_async(dispatch_get_main_queue(), {
//                    () -> Void in
//                    let url = Constants.AWS.AWS_DOMAIN + uploadRequest.key!
//                    success(url)
//                })
//            }
//            
//            return nil
//        }
//    }
//    
//   
//}
