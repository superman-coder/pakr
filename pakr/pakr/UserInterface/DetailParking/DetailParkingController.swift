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
    var parking : Parking?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentHeight = self.imageChitBottom.frame.origin.y + self.imageChitBottom.frame.size.height
        contentViewHeight.constant = contentHeight

        infoTableView.scrollEnabled = false
        infoTableHeight.constant = 135
        infoTableView.rowHeight = 45
        
        
        commentsTableView.scrollEnabled = false
        commentsTableHeight.constant = 150
        commentsTableView.rowHeight = 50
        //
        setData()
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        
        let nib = UINib(nibName: "PhotosCollectionViewCell", bundle: nil)
        photoCollectionView.registerNib(nib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - Private Method
    func setData(){
        
//        lblOpenTime.text = "\(parking?.schedule.first?.openTime)"
//        lblCloseTime.text = "\(parking?.schedule.first?.closeTime)"
//        lblAddress.text = parking?.addressName
//        lblBusinessReview.text = parking?.business.description
        lblOpenTime.text = "6:00"
        lblCloseTime.text = "24:00"
        lblAddress.text = "123, Phan Van A, Quan 1, HCM"
        lblBusinessReview.text = "abdd adk day la dia diem duoc danh gia cao ve chat luong phuc vu, xe duoc bao quan tot, co rua xe, mai che..:D"
        
//        imgParkingTop.setImageWithURL(NSURL(string:(parking?.imageUrl?.first)!)!, placeholderImage: UIImage(named: "parkingLot"))
        
        arrInfo = ["Direction","Call","More Info"]
        arrInfoImage = ["direction","call","more"]
        infoTableView.reloadData()
        
        arrCommentsImage = ["direction","call","more"]
        arrCommentUserName = ["Direction","Call","More Info"]
        arrCommentsDicriptions = ["aasdsad", "sdfsdfsdf", "sdfsfsfsf"]
        
    }
    
    func centerMapOnLocation(location: CLLocation){
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapkit.setRegion(coordinateRegion, animated: true)
    }

    



    @IBAction func didSelectMapView(sender: AnyObject) {
        let mapDetailViewController =  MapDetailViewController()
        mapDetailViewController.initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
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
            imgPackingOpaciti.alpha = 0.9 - offset/100
        }else{
            imgPackingOpaciti.alpha = 0.9
        }
        
        
    }
}

extension DetailParkingController: UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(infoTableView) {
           return (arrInfo?.count)!
        }else{
          return (arrCommentUserName?.count)!
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
            let cell = UITableViewCell()
            cell.imageView?.image = UIImage(named: arrCommentsImage![indexPath.row] as! String)
            cell.textLabel?.text = arrCommentUserName![indexPath.row] as? String
            cell.detailTextLabel?.text = arrCommentsDicriptions![indexPath.row] as? String
            return cell
        }
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
// - Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
            
        }
    }
    
    func callParkingOwn(){
//        let busPhone = self.parking
//        if let url = NSURL(string: "tel://\(busPhone)") {
//            UIApplication.sharedApplication().openURL(url)
//        }
    }
    func showMoreInfo(){
        presentViewController(MoreInfoViewController(), animated: true, completion: nil)
    }
    func openMapForPlace() {
        
        let latitute:CLLocationDegrees =   21.28277
        let longitute:CLLocationDegrees =   21.28277
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "item name"
        mapItem.openInMapsWithLaunchOptions(options)
    }
}

extension DetailParkingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier("PhotosCollectionViewCell", forIndexPath: indexPath) as! PhotosCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(120 , 120)
    }
    
    
    //UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
