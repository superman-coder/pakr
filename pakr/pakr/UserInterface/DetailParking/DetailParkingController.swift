//
//  DetailParkingController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/9/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import AFNetworking
import MapKit

class DetailParkingController: UIViewController {
    var parking : Parking!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var mapkit: MKMapView!

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var infoTableHeight: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentsTableHeight: NSLayoutConstraint!

    @IBOutlet weak var imageChitBottom: UIImageView!
    @IBOutlet weak var imgParkingTop: UIImageView!
    @IBOutlet weak var imgPackingOpaciti: UIImageView!
    
    @IBOutlet weak var lblOpenTime: UILabel!
    @IBOutlet weak var lblCloseTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblBusinessReview: UILabel!
    
    var arrInfo: NSArray?
    var arrInfoImage: NSArray?
    var arrCommentUserName: NSArray?
    var arrCommentsImage: NSArray?
    var arrCommentsDicriptions: NSArray?
    var arrUrlImageParking: NSArray?
    
    var numberImage: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.scrollEnabled = false
        commentsTableView.scrollEnabled = false
        //
        let nib = UINib(nibName: "PhotosCollectionViewCell", bundle: nil)
        photoCollectionView.registerNib(nib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        let nibComment = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentsTableView.registerNib(nibComment, forCellReuseIdentifier: "CommentTableViewCell")
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - Private Method

    func setData(){
        parking = JSONUtils.dummyParkingList.first
        
        arrUrlImageParking = parking.imageUrl
        numberImage = (arrUrlImageParking?.count)! + 1 ?? 1
        
        lblOpenTime.text = "\(parking.schedule.first!.openTime)"
        lblCloseTime.text = "\(parking.schedule.first!.closeTime)"
        lblAddress.text = parking.addressName
        lblBusinessReview.text = parking.business.businessDescription
        
        let url  = NSURL(string:(parking.imageUrl?.first)!)!
        imgParkingTop.setImageWithURL(url, placeholderImage: UIImage(named: "parkingLot"))
        arrInfo = ["Direction","Call","More Info"]
        arrInfoImage = ["direction","call","more"]
        infoTableView.reloadData()
        
//        arrCommentsImage = ["direction","call","more"]
//        arrCommentUserName = ["Direction","Call","More Info"]
//        arrCommentsDicriptions = ["aasdsad", "sdfsdfsdf", "sdfsfsfsf"]
        
        var row = arrCommentUserName?.count  ?? 0
        row += 5
        commentsTableHeight.constant = (CGFloat)((row-1)*120 + 60)
        centerMapOnLocation()
    }
    
    func centerMapOnLocation(){
        let location = CLLocation(latitude: parking.coordinate.latitude, longitude: parking.coordinate.longitude)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapkit.setRegion(coordinateRegion, animated: true)
    }

    
    func showCamera(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }

    
    func callParkingOwn(){
        let busPhone = self.parking.business.telephone
        if let url = NSURL(string: "tel://\(busPhone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    func showMoreInfo(){
        let info = MoreInfoViewController()
        info.parking = parking
        presentViewController(info, animated: true, completion: nil)
    }
    func openMapForPlace() {
        let latitute:CLLocationDegrees =   parking.coordinate.latitude
        let longitute:CLLocationDegrees =   parking.coordinate.longitude
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = parking.parkingName
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
    func startReview(){
        self.presentViewController(ReviewViewController(), animated: true, completion: nil)
    }
    func showReviewDetail(){
        self.presentViewController(ReviewDetailViewController(), animated: true, completion: nil)
    }
// MARK: - IBAction
    @IBAction func didSelectMapView(sender: AnyObject) {
        let mapDetailViewController =  MapDetailViewController()
        mapDetailViewController.initialLocation = CLLocation(latitude: parking.coordinate.latitude, longitude: parking.coordinate.longitude)
        self.presentViewController(mapDetailViewController, animated: false, completion: nil)
    }
    @IBAction func showBusinessReview(sender: AnyObject) {
    }
    @IBAction func showAddressDetail(sender: AnyObject) {
        didSelectMapView(sender)
    }
    @IBAction func bookMarkAction(sender: AnyObject) {
    }
}
// MARK: - Extension
//Animation in top when Scroll
extension DetailParkingController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = abs(scrollView.contentOffset.y)
        if offset > 0 {
            imgPackingOpaciti.alpha = 0.8 - offset/100
        }else{
            imgPackingOpaciti.alpha = 0.8
        }
    }
}

extension DetailParkingController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(infoTableView) {
           return (arrInfo?.count)!
        }else{
         var row = arrCommentUserName?.count  ?? 0
            row += 5
          return row
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.isEqual(infoTableView) {
            let cell = UITableViewCell()
            cell.imageView?.image = UIImage(named: arrInfoImage![indexPath.row] as! String)
            cell.textLabel?.text = arrInfo![indexPath.row] as? String
            cell.accessoryType = .DisclosureIndicator
            return cell
        }else{
            if indexPath.row == 0 {
                let cell = CommentTableViewCell.initCommentCellFromNib()
                return cell
            }else{
                let cell = CommentTableViewCell.initCommentsCellFromNib()
                return cell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(tableView.isEqual(commentsTableView)){
            if indexPath.row == 0 {
                return 60
            }else{
                return 120
            }
        }else{
            return 45
        }
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
// - Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: false)
        if tableView.isEqual(infoTableView) {
            switch indexPath.row {
            case 0:
                openMapForPlace()
            case 1:
                callParkingOwn()
            case 2:
                showMoreInfo()
            default:
                break
            }
        }else{
            if indexPath.row == 0 {
                                startReview()
            }else{
                                showReviewDetail()
            }
        }
    }
}

extension DetailParkingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
            cell.imageView.setImageWithURL(NSURL(fileURLWithPath: arrUrlImageParking![indexPath.row] as! String), placeholderImage:UIImage(named:"parkingLot"))
            return cell
        }

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(120 , 120)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == numberImage - 1 {
            showCamera()
        }else{
            
        }
    }
    
}

extension DetailParkingController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
         let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
