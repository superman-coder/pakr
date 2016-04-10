//
//  DetailParkingController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/9/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import AFNetworking

class DetailParkingController: UIViewController {
    @IBOutlet weak var imgParkingLot: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblTimeOpen: UILabel!
    @IBOutlet weak var lblTimeClose: UILabel!
    @IBOutlet weak var lblMotoPrice: UILabel!
    @IBOutlet weak var lblCarPrice: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    var parkingModel : Parking!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - Private Method
    func setData(){
//        if parkingModel == nil { return }
//        let imageUrl = parkingModel.imageUrl?.first
//        if imageUrl != nil {
//            imgParkingLot.setImageWithURL(NSURL(string: imageUrl!)!, placeholderImage: UIImage(named: "parkingLot"))
//        }
//        let avatarUrl = parkingModel.user.avatarUrl
//        if avatarUrl != nil {
//            imgUser.setImageWithURL(NSURL(string: avatarUrl!)!, placeholderImage:UIImage(named: "username"))
//        }
//        lblUserName.text = parkingModel.user.name
//        lblPhoneNumber.text = parkingModel.telphoneNumber
//
//        // warningformat day same region*/
//        let formatter = NSDateFormatter()
//        formatter.locale = NSLocale(localeIdentifier: "en_US")
//        formatter.dateFormat = "hh:mm a"
//        lblTimeClose.text = formatter.stringFromDate(parkingModel.openTime!)
//        lblAddress.text = parkingModel.addressName
//
//        lblTimeClose.text
//        lblMotoPrice
//        lblCarPrice
        
    }
    

    
    @IBAction func callAction(sender: AnyObject) {
        if parkingModel == nil { return }
        let busPhone = parkingModel.telphoneNumber
            if let url = NSURL(string: "tel://\(busPhone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    @IBAction func commentAction(sender: AnyObject) {
        self.presentViewController(CommentsViewController(), animated: true, completion: nil)
    }
}
