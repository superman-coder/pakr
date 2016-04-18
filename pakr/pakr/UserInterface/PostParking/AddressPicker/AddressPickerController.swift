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
    func addressPickerController(addressPicker:AddressPickerController, didFinishPickingLocationWithLatlng latlng:CLLocationCoordinate2D!, address:String?)
}

let searchCellReuseId = "GMPlaceCell"
class AddressPickerController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchControllerView: UIView!
    @IBOutlet weak var searchResultContainerView: UIView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var delegate: AddressPickerDelegate?
    
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
        searchControllerView.layer.borderColor = UIColor.yellowColor().CGColor
        searchControllerView.layer.borderWidth = 0.5
        searchTextField.delegate = self
        
        searchResultTableView.registerNib(UINib(nibName: "GMPlaceCell", bundle: nil), forCellReuseIdentifier: searchCellReuseId)
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
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
        delegate?.addressPickerController(self, didFinishPickingLocationWithLatlng: self.selectedLocation!, address: self.selectedAddress)
    }
    
    private func showSearchResultContainer(show:Bool) {
        let initialAlpha:CGFloat = show ? 0 : 1
        self.searchResultContainerView.alpha = initialAlpha
        self.searchResultContainerView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.searchResultContainerView.alpha = 1 - initialAlpha
            }) { (finished) in
                self.searchResultContainerView.hidden = !show
                
                if (show) {
                    self.searchTextField.becomeFirstResponder()
                } else {
                    self.searchTextField.resignFirstResponder()
                }
                
                self.searchTextField.text = nil
                self.searchResult.removeAll()
                self.searchResultTableView.reloadData()
        }
    }
    
    @IBAction func searchTextFieldTextChanged(sender: UITextField) {
        if sender.text == nil || sender.text!.characters.count == 0 {
            searchResult.removeAll()
            searchResultTableView.reloadData()
            return
        }
        
        placeSearchRequestTimer?.invalidate()
        let searchText = sender.text!
        placeSearchRequestTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AddressPickerController.requestSearchPlaces(_:)), userInfo: searchText, repeats: false)
    }
    
    @IBAction func searchControllerBackButtonDidClick(sender: UIButton) {
        self.showSearchResultContainer(false)
    }
    
    func requestSearchPlaces(sender:NSTimer) {
        let searchText = sender.userInfo as! String
        GMServices.requestAddressSearchWithAddress(searchText) { (success, location) in
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
    
    private func centerMapToCoordinate(latlng:CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(latlng, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
        mapView.setRegion(region, animated: true)
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
        centerMapToCoordinate(CLLocationCoordinate2D(latitude: gmPlace.geometry.latitude, longitude: gmPlace.geometry.longitude))
        self.showSearchResultContainer(false)
    }
}

