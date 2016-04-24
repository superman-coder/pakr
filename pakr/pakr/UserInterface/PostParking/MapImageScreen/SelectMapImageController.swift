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
    
    weak var postParkingController: PostParkingController?
    
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var collectionVIew: UICollectionView!
    @IBOutlet weak var btnCover: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblParkingName: UILabel!
    
    var parking: Parking!
    var parkingLocation:CLLocationCoordinate2D?
    
    var arrImageParking: NSMutableArray?
    var imageCover:UIImage!
    var numberImage: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LayoutUtils.dropShadowView(imageViewCover)
        LayoutUtils.dropShadowView(mapView)
        LayoutUtils.dropShadowView(collectionVIew)
        
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

    
    func showImagePicker(numberOfSelect: Int, complete:((images: [UIImage]) -> Void) ) {
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = numberOfSelect
        
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
                
                var i = 0
                let arrImage = NSMutableArray()
                for asset in assets {
                    manager.requestImageForAsset(asset, targetSize: targetSize, contentMode: .AspectFit
                        , options: requestOptions, resultHandler: { (image: UIImage?, dic: [NSObject : AnyObject]?) in
                            i = i + 1
                            arrImage.addObject(image!)
                            if i == assets.count {
                                complete(images: arrImage.copy() as! [UIImage])
                            }
                    })
                }
                
            }, completion: {
        })
        
    }
    @IBAction func getImageCover(sender: AnyObject) {
        showImagePicker(1) { (images) in
            self.imageCover = images.first
            self.imageViewCover.image = self.imageCover
            if images.first != nil {
                self.btnCover.selected = true
            }
        }
    }
    @IBAction func onTapInMapView(sender: AnyObject) {
        let addressPicker = AddressPickerController()
        addressPicker.delegate = self
        presentViewController(addressPicker, animated: true, completion: nil)
    }
}
extension SelectMapImageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(120 , 120)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == numberImage - 1 {
            showImagePicker(20, complete: { (images) in
                self.arrImageParking?.addObjectsFromArray(images)
                self.numberImage = self.arrImageParking!.count + 1
                self.collectionVIew.reloadData()
            })
        }else{
            
        }
    }
    
}
extension SelectMapImageController: AddressPickerDelegate {
    func addressPickerController(addressPicker:AddressPickerController, didFinishPickingLocationWithLatlng latlng:CLLocationCoordinate2D!, address:String?) {
        parkingLocation = latlng
        let region = MKCoordinateRegionMakeWithDistance(latlng, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
        mapView.setRegion(region, animated: true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addressPickerControllerDidCancel(addressPicker:AddressPickerController){
        dismissViewControllerAnimated(true, completion: nil)
    }
}
