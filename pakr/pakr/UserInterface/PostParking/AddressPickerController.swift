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

class AddressPickerController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var delegate: AddressPickerDelegate?
    
    var selectedLocation:CLLocationCoordinate2D?
    var selectedAddress:String?
    
    private var geoCodeRequestTimer:NSTimer?
    
    private let centerPinLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
        initSearchBar()
    }
    
    private func initMapView() {
        mapView.delegate = self
        
        if let initialLocation = selectedLocation {
            let region = MKCoordinateRegionMakeWithDistance(initialLocation, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
            mapView.setRegion(region, animated: true)
        }
        
        centerPinLayer.contents = UIImage(named: "pin-orange")?.CGImage
        centerPinLayer.bounds = CGRectMake(0, 0, 29, 42)
        let bounds = mapView.bounds
        centerPinLayer.position = CGPointMake(bounds.size.width / 2, bounds.size.height / 2)
        centerPinLayer.anchorPoint = CGPointMake(0.5, 1)
        centerPinLayer.hidden = true
        mapView.layer.addSublayer(centerPinLayer)
    }
    
    private func initSearchBar() {
        searchBar.delegate = self
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
        self.searchContainerView.alpha = initialAlpha
        self.searchContainerView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.searchContainerView.alpha = 1 - initialAlpha
            }) { (finished) in
                self.searchContainerView.hidden = !show
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
        
        geoCodeRequestTimer?.invalidate()
        geoCodeRequestTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AddressPickerController.reverseGeoCodeRequest), userInfo: nil, repeats: false)
    }
    
    func reverseGeoCodeRequest() {
        guard let _ = selectedLocation else {
            return
        }
        
        GMGeocodeServices.reverseGeocodeRequest(selectedLocation!.latitude, longitude: selectedLocation!.longitude) { (success, address) in
            if success {
                self.addressLabel.text = address
                self.selectedAddress = address
            } else {
                self.addressLabel.text = "Error"
            }
        }
    }
}

extension AddressPickerController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.showSearchResultContainer(true)
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.showSearchResultContainer(false)
        self.searchBar.resignFirstResponder()
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
}

