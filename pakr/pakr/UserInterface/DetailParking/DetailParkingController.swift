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
    @IBOutlet weak var fromBusinessView: UIControl!
    @IBOutlet weak var addressView: UIControl!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var mapkit: MKMapView!
    @IBOutlet weak var btnBookMark: UIButton!

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var infoTableHeight: NSLayoutConstraint!
    @IBOutlet weak var commentsTableHeight: NSLayoutConstraint!

    @IBOutlet weak var imageChitBottom: UIImageView!
    @IBOutlet weak var imgParkingTop: UIImageView!
    @IBOutlet weak var imgPackingOpaciti: UIImageView!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblBusinessReview: UILabel!
    @IBOutlet weak var rating: RatingControl!
    @IBOutlet weak var hoursToday: UILabel!
    @IBOutlet weak var numReviews: UILabel!
    
    var arrInfo: NSArray?
    var arrInfoImage: NSArray?
    var arrCommentUserName: NSArray?
    var arrCommentsImage: NSArray?
    var arrCommentsDicriptions: NSArray?
    var arrUrlImageParking: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.scrollEnabled = false
        commentsTableView.scrollEnabled = false
        //
        self.navigationController?.navigationBar.translucent = false
        if (self.respondsToSelector(Selector("edgesForExtendedLayout"))) {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
        //
        let nib = UINib(nibName: "PhotosCollectionViewCell", bundle: nil)
        photoCollectionView.registerNib(nib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        let nibComment = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentsTableView.registerNib(nibComment, forCellReuseIdentifier: "CommentTableViewCell")
        setData()
        
        self.title = parking.parkingName
        setShadow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - Private Method

    func setShadow(){
        LayoutUtils.dropShadowView(photoCollectionView)
        LayoutUtils.dropShadowView(infoTableView)
        LayoutUtils.dropShadowView(commentsTableView)
        LayoutUtils.dropShadowView(mapkit)
        LayoutUtils.dropShadowView(imgParkingTop)
        LayoutUtils.dropShadowView(imageChitBottom)
        LayoutUtils.dropShadowView(addressView)
        LayoutUtils.dropShadowView(fromBusinessView)
    }
    func setData(){        
        arrUrlImageParking = parking.imageUrl
        lblAddress.text = parking.addressName
        lblBusinessReview.text = parking.business.businessDescription

        var dayOfWeek = getDayOfWeek()
        if dayOfWeek == 1 {
            dayOfWeek = 6
        }else{
            dayOfWeek = dayOfWeek - 2
        }
        if parking.schedule.count >= 6 {
            let closeTime = "\(parking.schedule[dayOfWeek].closeTime)"
            let openTime = "\(parking.schedule[dayOfWeek].openTime)"
            hoursToday.text = "Hours ToDay: \(openTime) - \(closeTime)"
        }
        rating.rating = 3
        numReviews.text = "197 Reviews"
        
        if parking.imageUrl != nil {
            let url  = NSURL(string:(parking.imageUrl?.first)!)!
            imgParkingTop.setImageWithURL(url, placeholderImage: nil)
        }
        arrInfo = ["Direction","Call","More Info"]
        arrInfoImage = ["direction","call","more"]
        infoTableView.reloadData()

        centerMapOnLocation()
    }
    func getDayOfWeek()->Int {
        let today = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: today)
        let weekDay = myComponents.weekday
        return weekDay
    }
    
    func centerMapOnLocation(){
        let location = CLLocation(latitude: parking.coordinate.latitude, longitude: parking.coordinate.longitude)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapkit.setRegion(coordinateRegion, animated: true)
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
        self.navigationController?.pushViewController(info, animated: true)
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
        let reviewCOntroler = ReviewViewController()
        reviewCOntroler.delegate = self
        self.navigationController?.pushViewController(reviewCOntroler, animated: true)
    }
    func showAllComments(){
        self.navigationController?.pushViewController(ShowAllCommentTableViewController(), animated: true)
    }
// MARK: - IBAction
    @IBAction func didSelectMapView(sender: AnyObject) {
        let mapDetailViewController =  MapDetailViewController()
        mapDetailViewController.initialLocation = CLLocation(latitude: parking.coordinate.latitude, longitude: parking.coordinate.longitude)
        self.navigationController?.pushViewController(mapDetailViewController, animated: true)
    }
    @IBAction func showBusinessReview(sender: AnyObject) {
    }
    @IBAction func showAddressDetail(sender: AnyObject) {
        didSelectMapView(sender)
    }
    @IBAction func bookMarkAction(sender: AnyObject) {
        if  btnBookMark.selected {
            btnBookMark.selected = false
        }else{
            btnBookMark.selected = true
        }
        
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
               let  authenService = WebServiceFactory.getAuthService()
                let user = authenService.getLoginUser()
                if user != nil{
                    cell.disPlay((user?.avatarUrl)!, name: (user?.name)!)
                }
                return cell
            }else{
                let cell = CommentTableViewCell.initSeeAllComment()
                return cell
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(tableView.isEqual(commentsTableView)){
            if indexPath.row == 0 {
                return 60
            }else{
                return 40
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
                                showAllComments()
            }
        }
    }
}

extension DetailParkingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrUrlImageParking?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: PhotosCollectionViewCell = collectionView .dequeueReusableCellWithReuseIdentifier("PhotosCollectionViewCell", forIndexPath: indexPath) as! PhotosCollectionViewCell
        cell.disPlay(arrUrlImageParking![indexPath.row] as! String)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(120 , 120)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }
    
}


extension DetailParkingController: ReviewViewControllerDelegate{
    func DidPostReview(rating: Int, title: String, content: String) {
        print(rating)
        print(title)
        print(content)
    }
}
