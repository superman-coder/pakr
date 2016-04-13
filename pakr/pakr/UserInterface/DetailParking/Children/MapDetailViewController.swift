//
//  MapDetailViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/12/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MapKit

class MapDetailViewController: UIViewController {
    @IBOutlet weak var mapVIew: MKMapView!
    var initialLocation: CLLocation? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(initialLocation!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation){
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapVIew.setRegion(coordinateRegion, animated: true)
    }

    @IBAction func dismissSelf(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
