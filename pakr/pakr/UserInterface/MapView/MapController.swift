//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import MapKit

let MAP_DEFAULT_RADIUS:CLLocationDistance = 800


class MapController: UIViewController {

    @IBOutlet weak var parkMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var parkingList: [Topic]! = []
    var parkingDataLoadingRadius:Double = 0
    
    // Center point on Map
    var currentCenterLocation: CLLocationCoordinate2D?
    // Center point that used to load data
    var currentDataCenterLocation: CLLocationCoordinate2D?
    var currentUserLocation: CLLocationCoordinate2D?
    
    // When user first time open app, we will wating for a valid current user location
    var startUpdatingParkingData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        initMapView()
        fillAnnotationOnMap(self.createAnnotationList(self.parkingList))
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
    }
    
    func fillAnnotationOnMap(listAnnotation:[ParkAnnotation]) {
        self.parkMapView.addAnnotations(listAnnotation)
    }
    
    func createAnnotationList(parkingList:[Topic]!) -> [ParkAnnotation] {
        var listAnnotation:[ParkAnnotation] = []
        for topic in parkingList {
            let parking = topic.parking
            
            let annotation = ParkAnnotation(title: "Parking name", subtitle: nil, coordinate: CLLocationCoordinate2DMake(parking.coordinate.latitude, parking.coordinate.longitude))
            listAnnotation.append(annotation)
        }
        return listAnnotation
    }
    
    func initialLocation() -> CLLocationCoordinate2D? {
        return NSUserDefaults.standardUserDefaults().getLastSavedLocation()
    }
    
    func mapViewRadius() -> Double {
        let bottomrightScreenPoint = CGPointMake(CGRectGetMaxX(parkMapView.bounds), CGRectGetMaxY(parkMapView.bounds))
        let topleftScreenPoint = CGPointZero
        
        let topleftLocation = self.parkMapView.convertPoint(topleftScreenPoint, toCoordinateFromView: self.parkMapView).CLLocationPoint()
        let bottomrightLocation = self.parkMapView.convertPoint(bottomrightScreenPoint, toCoordinateFromView: self.parkMapView).CLLocationPoint()
        
        let distance = bottomrightLocation.distanceFromLocation(topleftLocation)
        let radius = (distance > 0 ? distance : -distance) / 2
        print("Radius of data load \(radius)")
        
        return radius
    }
    
    func loadDataWithCenter(latitude:Double, longitude:Double, radius:Double) {
        print("Load data with center: (\(latitude),\(longitude)) radius: \(radius)")
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
        
        if DataServiceUtil.needToReloadParking(currentDataCenterLocation, newLocation: currentCenterLocation, lastDataLoadingRadius: parkingDataLoadingRadius, newMapViewRadius: mapViewRadius) {
            currentDataCenterLocation = currentCenterLocation
            parkingDataLoadingRadius = mapViewRadius * 1.5
            
            self.loadDataWithCenter(currentDataCenterLocation!.latitude, longitude: currentDataCenterLocation!.longitude, radius: parkingDataLoadingRadius)
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        self.currentUserLocation = userLocation.coordinate
        
        if currentCenterLocation == nil || !CLLocationCoordinate2DIsValid(currentCenterLocation!) {
            currentCenterLocation = userLocation.coordinate
        } else {
            
        }
    }
}

extension MapController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}


