//
//  TestUploadController.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/18/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import AWSS3

class TestUploadController: UIViewController {
    
    @IBOutlet weak var localImageView: UIImageView!

    @IBOutlet weak var uploadImageView: UIImageView!
    
    var imageURL: NSURL!
    var imagePicker: UIImagePickerController!
    let awsClient = AWSClient()
    
    // var uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    // var uploadFileURLs = Array<NSURL?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //localImageView.contentMode = .ScaleAspectFit
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
    }
    
    @IBAction func uploadImageEvent(sender: AnyObject) {
    }
    
    
    @IBAction func loadImageViewEvent(sender: AnyObject) {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension TestUploadController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            localImageView.image = image
            
            awsClient.uploadImage("hqthao", image: image,
                success: {
                    Void -> Void in
                    print("success upload")
                    self.uploadImageView.setImageWithURL(NSURL(string: "https://farm1.staticflickr.com/2/1418878_1e92283336_m.jpg")!)
                },
                error: {
                    Void -> Void in
                },
                progress: {
                    Int -> Void in
                }
            )
            
        }
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension TestUploadController: UINavigationControllerDelegate {
    
}