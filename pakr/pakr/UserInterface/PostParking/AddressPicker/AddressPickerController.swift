//
//  AddressPickerController.swift
//  pakr
//
//  Created by Tien on 4/16/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol AddressPickerDelegate {
    func addressPickerControllerDidCancel(addressPicker:AddressPickerController);
    func addressPickerController(addressPicker:AddressPickerController, didFinishPickingLocationWithLatlng latlng:CLLocationCoordinate2D!, address:String?, image:UIImage?)
}

let searchCellReuseId = "GMPlaceCell"
class AddressPickerController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchControllerView: UIView!
    @IBOutlet weak var searchResultContainerView: UIView!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchIconButton: UIButton!
    @IBOutlet weak var bottomBarView: UIView!
    
    var delegate: AddressPickerDelegate?
    var isQuerying = false
    var currentSearchQuery:String?
    var latestSearchQuery:String?
    
    var selectedLocation:CLLocationCoordinate2D?
    var selectedAddress:String?
    
    private var reverseGeoCodeRequestTimer:NSTimer?
    private var placeSearchRequestTimer:NSTimer?
    
    private let centerPinLayer = CALayer()
    
    // Search functions
    var searchResult: [GMPlace]! = []
    // A boolean indicates if we should perform a search when text changes.
    var shouldSearch = true
    
    // End of search functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
        initSearchController()
    }
    
    private func initMapView() {
        mapView.delegate = self
        
        if let initialLocation = selectedLocation {
            centerMapToCoordinate(initialLocation)
        }
        
        centerPinLayer.contents = UIImage(named: "pin-orange")?.CGImage
        centerPinLayer.bounds = CGRectMake(0, 0, 29, 42)
        let bounds = mapView.bounds
        centerPinLayer.position = CGPointMake(bounds.size.width / 2, bounds.size.height / 2)
        centerPinLayer.anchorPoint = CGPointMake(0.5, 1)
        centerPinLayer.hidden = true
        mapView.layer.addSublayer(centerPinLayer)
    }
    
    private func initSearchController() {
        LayoutUtils.dropShadowView(searchControllerView)
        searchTextField.delegate = self
        searchTextField.placeholder = "Search nearby address"
        searchResultTableView.registerNib(UINib(nibName: "GMPlaceCell", bundle: nil), forCellReuseIdentifier: searchCellReuseId)
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        
        bottomBarView.layer.masksToBounds = false
        bottomBarView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomBarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bottomBarView.layer.shadowOpacity = 0.4
    }
    
    override func viewDidLayoutSubviews() {
        let bounds = mapView.bounds
        centerPinLayer.position = CGPointMake(bounds.size.width / 2, bounds.size.height / 2)
        centerPinLayer.hidden = false
    }
    
    @IBAction func buttonCancelDidClick(sender: UIBarButtonItem) {
        delegate?.addressPickerControllerDidCancel(self)
    }
    
    @IBAction func buttonDoneDidClick(sender: UIBarButtonItem) {
        snapshotMapViewWithComplete { (snapshot, error) in
            self.delegate?.addressPickerController(self, didFinishPickingLocationWithLatlng: self.selectedLocation!, address: self.selectedAddress, image: snapshot)
        }
    }
    
    private func showSearchResultContainer(show:Bool) {
        if (show != self.searchResultContainerView.hidden) {
            return
        }
        // show true, hidden = false -> return
        // show false hidden = true -> return
        // show true, hidden = true -> do
        // show false, hidden = false -> do
        let initialAlpha:CGFloat = show ? 0 : 1
        self.searchResultContainerView.alpha = initialAlpha
        self.searchResultContainerView.hidden = false
        
        if (show) {
            self.searchTextField.becomeFirstResponder()
        } else {
            self.searchTextField.resignFirstResponder()
        }
        
//        self.searchTextField.text = nil
        self.searchResult.removeAll()
        self.searchResultTableView.reloadData()
        
        UIView.animateWithDuration(0.3, animations: {
            self.searchResultContainerView.alpha = 1 - initialAlpha
            }) { (finished) in
                self.searchResultContainerView.hidden = !show
                
        }
        
        let targetImage = show ? UIImage(named: "back-gray") : UIImage(named: "search-gray")
        UIView.transitionWithView(self.searchIconButton, duration: 0.3, options: .TransitionCrossDissolve, animations: { 
            self.searchIconButton .setImage(targetImage, forState: .Normal)
            }) { (finished) in
                
        }
    }
    
    @IBAction func searchTextFieldTextChanged(sender: UITextField) {
        latestSearchQuery = sender.text
        
        if sender.text == nil || sender.text!.characters.count == 0 {
            searchResult.removeAll()
            searchResultTableView.reloadData()
            return
        }
        
        let searchText = sender.text!
        if (!isQuerying) {
            requestSearchPlaces(searchText);
        }
    }
    
    @IBAction func searchControllerBackButtonDidClick(sender: UIButton) {
        self.showSearchResultContainer(false)
    }
    
    func requestSearchPlaces(searchText: String) {
        isQuerying = true
        currentSearchQuery = searchText
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        GMServices.requestAddressSearchWithAddress(searchText) { (success, location) in
            self.isQuerying = false
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.onQueryFinished()
            self.handleSearchResult(success, locations: location)
        }
    }
    
    private func handleSearchResult(success:Bool, locations:[GMPlace]?) {
        self.searchResult.removeAll()
        if success {
            self.searchResult.appendContentsOf(locations!)
        } else {
            // TODO: Handle search error
        }
        self.searchResultTableView.reloadData()
    }
    
    private func onQueryFinished() {
        if currentSearchQuery != nil && latestSearchQuery != nil && currentSearchQuery != latestSearchQuery {
            requestSearchPlaces(latestSearchQuery!)
        }
    }
    
    private func centerMapToCoordinate(latlng:CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(latlng, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
        mapView.setRegion(region, animated: true)
    }
    
    private func snapshotMapViewWithComplete(completion:(snapshot:UIImage?, error:NSError?)->()) {
        let snapshotOption = MKMapSnapshotOptions()
        snapshotOption.region = mapView.region
        snapshotOption.size = CGSizeMake(mapView.frame.size.width, mapView.frame.size.height / 2)
        snapshotOption.scale = UIScreen.mainScreen().scale
        let snapshoter = MKMapSnapshotter(options: snapshotOption)
        snapshoter.startWithQueue(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { (snapshot:MKMapSnapshot?, error:NSError?) in
            
            guard let snapshot = snapshot else {
                completion(snapshot: nil, error: error)
                return
            }
            
            let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
            let mapImage = snapshot.image
            UIGraphicsBeginImageContextWithOptions(mapImage.size, true, mapImage.scale)
            mapImage.drawAtPoint(CGPoint.zero)
            var point = snapshot.pointForCoordinate(self.selectedLocation!)
            point.x = point.x + pin.centerOffset.x - (pin.bounds.size.width / 2)
            point.y = point.y + pin.centerOffset.y - (pin.bounds.size.height / 2)
            pin.image?.drawAtPoint(point)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue(), { 
                completion(snapshot: image, error: nil)
            })
        }
    }
}

extension AddressPickerController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.addressLabel.text = "Moving"
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.addressLabel.text = "Loading"
        
        selectedLocation = mapView.region.center
        
        reverseGeoCodeRequestTimer?.invalidate()
        reverseGeoCodeRequestTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AddressPickerController.reverseGeoCodeRequest), userInfo: nil, repeats: false)
    }
    
    func reverseGeoCodeRequest() {
        guard let _ = selectedLocation else {
            return
        }
        
        GMServices.reverseGeocodeRequest(selectedLocation!.latitude, longitude: selectedLocation!.longitude) { (success, address) in
            if success {
                self.addressLabel.text = address
                self.selectedAddress = address
            } else {
                self.addressLabel.text = "Error"
            }
        }
    }
}

extension AddressPickerController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.shouldSearch = true
        textField.text = ""
        self.showSearchResultContainer(true)
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.shouldSearch = false
    }
    
}

extension AddressPickerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(searchCellReuseId) as! GMPlaceCell
        let gmPlace = searchResult[indexPath.row]
        cell.configWithName(gmPlace.name, address: gmPlace.address)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let gmPlace = searchResult[indexPath.row]
        searchTextField.text = gmPlace.name
        centerMapToCoordinate(CLLocationCoordinate2D(latitude: gmPlace.geometry.latitude, longitude: gmPlace.geometry.longitude))
        self.showSearchResultContainer(false)
    }
}


