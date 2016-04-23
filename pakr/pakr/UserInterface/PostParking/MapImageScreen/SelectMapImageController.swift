//
// Created by Huynh Quang Thao on 4/11/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import Material
import BSImagePicker
import Photos
import MapKit

class SelectMapImageController: BaseViewController {

    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblParkingName: UILabel!
    @IBOutlet weak var testTextField: TextField!
    
    var parking: Parking!
    var parkingLocation:CLLocationCoordinate2D?
    
    var arrImageParking: NSMutableArray?
    var numberImage: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTextField(testTextField, placeHolder: "Hello", text: "World")
        let nib = UINib(nibName: "PhotosCollectionViewCell", bundle: nil)
        collectionVIew.registerNib(nib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        
        arrImageParking = NSMutableArray()
        numberImage = arrImageParking!.count + 1
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        lblParkingName.text = parking.parkingName
    }
    func updateTextField(textField: TextField!, placeHolder: String!, text: String!) {
//        textField.placeholder = placeHolder
//        textField.placeholderTextColor = MaterialColor.grey.base
//        textField.font = RobotoFont.regularWithSize(12)
//        textField.textColor = MaterialColor.black
//        textField.text = text
//        
//        
//        textField.detailLabel = UILabel()
//        textField.titleLabel!.font = RobotoFont.mediumWithSize(12)
//        textField.titleLabelColor = MaterialColor.grey.base
//        textField.titleLabelActiveColor = MaterialColor.blue.accent3
//        
//        let image = UIImage(named: "ic_close_white")?.imageWithRenderingMode(.AlwaysTemplate)
        
        //        let clearButton: FlatButton = FlatButton()
        //        clearButton.pulseColor = MaterialColor.grey.base
        //        clearButton.pulseScale = false
        //        clearButton.tintColor = MaterialColor.grey.base
        //        clearButton.setImage(image, forState: .Normal)
        //        clearButton.setImage(image, forState: .Highlighted)
        //
        //        textField.clearButton = clearButton
        
        //textField.detailLabelActiveColor = MaterialColor.red.accent3
    }
    
     func showImagePicker( ) {
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 6
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            print("Selected: \(asset)")
            }, deselect: { (asset: PHAsset) -> Void in
                print("Deselected: \(asset)")
            }, cancel: { (assets: [PHAsset]) -> Void in
                print("Cancel: \(assets)")
            }, finish: { (assets: [PHAsset]) -> Void in
                print("Finish: \(assets)")
                let manager = PHImageManager.defaultManager()
                let scale = UIScreen.mainScreen().scale
                let targetSize = CGSizeMake(80*scale, 80*scale)
                
                let requestOptions = PHImageRequestOptions()
                requestOptions.resizeMode   = .Exact
                requestOptions.deliveryMode = .HighQualityFormat

                for asset in assets {
                    manager.requestImageForAsset(asset, targetSize: targetSize, contentMode: .AspectFit
                        , options: requestOptions, resultHandler: { (image: UIImage?, dic: [NSObject : AnyObject]?) in
                            self.arrImageParking?.addObject(image!)
                            self.numberImage = self.numberImage + 1
                            self.collectionVIew.insertItemsAtIndexPaths([NSIndexPath(forItem: (self.arrImageParking?.count)! - 1 , inSection: 0)])
                    })
                }

            }, completion: {
        })
        
    }
    @IBAction func onTapInMapView(sender: AnyObject) {
        let addressPicker = AddressPickerController()
        addressPicker.delegate = self
        presentViewController(addressPicker, animated: true, completion: nil)
    }
}
extension SelectMapImageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberImage
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row == numberImage - 1{
            let cell: PhotosCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier("PhotosCollectionViewCell", forIndexPath: indexPath) as! PhotosCollectionViewCell
            cell.imageView.image = UIImage(named: "Camera")
            return cell
        }else{
            let cell: PhotosCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier("PhotosCollectionViewCell", forIndexPath: indexPath) as! PhotosCollectionViewCell
            cell.imageView.image = arrImageParking![indexPath.row] as? UIImage
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(120 , 120)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == numberImage - 1 {
            showImagePicker()
        }else{
            
        }
    }
    
}
extension SelectMapImageController: AddressPickerDelegate {
    func addressPickerController(addressPicker:AddressPickerController, didFinishPickingLocationWithLatlng latlng:CLLocationCoordinate2D!, address:String?){
        parkingLocation = latlng
        let region = MKCoordinateRegionMakeWithDistance(latlng, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
        mapView.setRegion(region, animated: true)
    }
    func addressPickerControllerDidCancel(addressPicker:AddressPickerController){
        
    }
}
