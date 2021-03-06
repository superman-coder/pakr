//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Parse

let MAP_DEFAULT_RADIUS:CLLocationDistance = 800


class MapController: UIViewController {

    @IBOutlet weak var parkMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var parkingList: [Topic]! = []
    var parkingDataLoadingRadius:Double = 0
    
    var serviceAvailable = false
    
    // Rarely modified.
//    let centerPinLayer = CALayer()
    var pinImage: UIImage?
    
    
    // Center point on Map
    var currentCenterLocation: CLLocationCoordinate2D?
    // Center point that used to load data
    var currentDataCenterLocation: CLLocationCoordinate2D?
    var currentUserLocation: CLLocationCoordinate2D?
    
    // When user first time open app, we will wating for a valid current user location
    var startUpdatingParkingData = false
    
    // MARK: - Init controller
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        
        setupLocationManager()
        initMapView()
    }
    
    func setupLocationManager() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func initMapView() {
        parkMapView.delegate = self
        
        let initialLocation = self.initialLocation()
        
        if let initialLocation = initialLocation {
            let region = MKCoordinateRegionMakeWithDistance(initialLocation, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
            parkMapView.setRegion(region, animated: true)
        }
        
        let button = UIButton(type: .Custom)
        button.backgroundColor = UIColor.whiteColor()
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(MapController.buttonMyLocationDidClick(_:)), forControlEvents: .TouchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "current-location")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        button.tintColor = UIColor.primaryColor()
        
        button.imageView?.contentMode = .ScaleAspectFit
        
        let views = ["button":button]
        self.parkMapView.addSubview(button)
        self.parkMapView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[button(48)]-(8)-|", options: [], metrics: nil, views: views))
        self.parkMapView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[button(48)]-(8)-|", options: [], metrics: nil, views: views))
        
/* Realize that no need to add center pin - TIEN
        centerPinLayer.contents = UIImage(named: "pin-orange")?.CGImage
        centerPinLayer.bounds = CGRectMake(0, 0, 29, 42)
        let bounds = parkMapView.bounds
        centerPinLayer.position = CGPointMake(bounds.size.width / 2, bounds.size.height / 2)
        centerPinLayer.anchorPoint = CGPointMake(0.5, 1)
        parkMapView.layer.addSublayer(centerPinLayer)
 */
    }
    
    func buttonMyLocationDidClick(sender:UIButton) {
        if let myLocation = self.currentUserLocation {
            let region = MKCoordinateRegionMakeWithDistance(myLocation, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
            parkMapView.setRegion(region, animated: true)
        }
    }
    
    func reload() {
        fillAnnotationOnMap(self.createAnnotationList(self.parkingList))
    }
    
    func fillAnnotationOnMap(listAnnotation:[ParkAnnotation]) {
        self.parkMapView.removeAnnotations(self.parkMapView.annotations)
        self.parkMapView.addAnnotations(listAnnotation)
    }
    
    func createAnnotationList(parkingList:[Topic]!) -> [ParkAnnotation] {
        var listAnnotation:[ParkAnnotation] = []

        for i in 0..<parkingList.count {
            let topic = parkingList[i];
            let parking = topic.parking
            
            let annotation = ParkAnnotation(title: parking.parkingName, subtitle: nil, coordinate: CLLocationCoordinate2DMake(parking.coordinate.latitude, parking.coordinate.longitude), tag: i)
            listAnnotation.append(annotation)
        }
        
        return listAnnotation
    }
    
    func initialLocation() -> CLLocationCoordinate2D? {
        return NSUserDefaults.standardUserDefaults().getLastSavedLocation()
    }
    
    // MARK: -
    func mapViewRadius() -> Double {
        let bottomrightScreenPoint = CGPointMake(CGRectGetMaxX(parkMapView.bounds), CGRectGetMaxY(parkMapView.bounds))
        let topleftScreenPoint = CGPointZero
        
        let topleftLocation = self.parkMapView.convertPoint(topleftScreenPoint, toCoordinateFromView: self.parkMapView).CLLocationPoint()
        let bottomrightLocation = self.parkMapView.convertPoint(bottomrightScreenPoint, toCoordinateFromView: self.parkMapView).CLLocationPoint()
        
        let distance = bottomrightLocation.distanceFromLocation(topleftLocation)
        let radius = (distance > 0 ? distance : -distance) / 2
//        print("Radius of data load \(radius)")
        
        return radius
    }
    
    func loadDataWithCenter(latitude:Double, longitude:Double, radius:Double) {
//        print("Load data with center: (\(latitude),\(longitude)) radius: \(radius)")
        WebServiceFactory.getAddressService().getNearByParkingLotByLocation(latitude, longitude: longitude, radius: radius, success: { topics in
            self.parkingList = topics
                self.reload()
            }) { error in
                
        }
//        parkingList = JSONUtils.dummyTopicList
        
    }
}

extension MapController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        currentCenterLocation = mapView.region.center
        
        let mapViewRadius = self.mapViewRadius()
        // Dont know why bounds of mapview become Zero, in that case, mapViewRadius is Zero too, 
        // Here we will skip that case.
        if mapViewRadius == 0 {
            return
        }
        
        if DataServiceUtils.needToReloadParking(currentDataCenterLocation, newLocation: currentCenterLocation, lastDataLoadingRadius: parkingDataLoadingRadius, newMapViewRadius: mapViewRadius) {
            currentDataCenterLocation = currentCenterLocation
            parkingDataLoadingRadius = mapViewRadius * 1.5
            
            self.loadDataWithCenter(currentDataCenterLocation!.latitude, longitude: currentDataCenterLocation!.longitude, radius: parkingDataLoadingRadius)
        }
    }
    
    
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        self.currentUserLocation = userLocation.coordinate
        
        if (!serviceAvailable) {
            let region = MKCoordinateRegionMakeWithDistance(currentUserLocation!, MAP_DEFAULT_RADIUS, MAP_DEFAULT_RADIUS)
            parkMapView.setRegion(region, animated: true)
            serviceAvailable = true
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation.isKindOfClass(MKUserLocation)) {
            return nil;
        }
        
        let reuseIdentifier = "pakr_annotation"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        if pinImage == nil {
            pinImage = PakrImageUtils.resizeImage(UIImage(named: "pin-orange")!, toSize: CGSizeMake(29, 42))
        }
        
        if let pakrAnnotation = annotation as? ParkAnnotation {
            annotationView?.tag = pakrAnnotation.tag
        }
        annotationView?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        annotationView?.canShowCallout = true
        annotationView?.image = pinImage
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let tag = view.tag
        let topic = self.parkingList[tag];
        let detailVc = DetailParkingController(nibName: "DetailParkingController", bundle: nil)
        detailVc.topic = topic
        
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

extension MapController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}


