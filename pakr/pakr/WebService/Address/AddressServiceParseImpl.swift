//
// Created by Huynh Quang Thao on 4/7/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

public class AddressServiceParseImpl: NSObject, AddressService {
    func getNearByParkingLotByLocation(latitude: Double!, longitude: Double, radius: Double, success: ([Topic] -> Void), fail: (NSError -> Void)) {
        let query = PFQuery(className: Constants.Table.Topic)
        query.includeKey(Topic.PKParking)
        let innerQuery = PFQuery(className: Constants.Table.Parking)
        innerQuery.whereKey(Parking.PKCoordinate, nearGeoPoint: PFGeoPoint(latitude: latitude, longitude: longitude), withinKilometers: radius / 1000)
        
        query.whereKey(Topic.PKParking, matchesQuery: innerQuery)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            print("Near by count: \(objects?.count)")
            print("Error: \(error)")
            
            if let error = error {
                fail(error)
            } else if let objs = objects {
                var topics = [Topic]()
                for pfobj in objs {
                    let topic = Topic(pfObject: pfobj)
                    topics.append(topic)
                }
                success(topics)
            }
        }
    }
    
    func getNearByParkingByAddressName(address: String, radius: Double, success: ([Topic] -> Void), fail: (NSError -> Void)) {
        GMServices.requestAddressSearchWithAddress(address) { (successGMS, locationGMS) in
            var coord:Coordinate? = nil
            
            if (successGMS) {
                if locationGMS?.count > 0 {
                    let firstPlace = locationGMS![0]
                    print("Search nearby: \(firstPlace.geometry.latitude),\(firstPlace.geometry.longitude)")
                    coord = Coordinate(latitude: firstPlace.geometry.latitude, longitude: firstPlace.geometry.longitude)
                }
            }
            
            if let coord = coord {
                self.getNearByParkingLotByLocation(coord.latitude,
                                                   longitude: coord.longitude,
                                                   radius: radius,
                                                   success: { topic in
                    success(topic)
                    }, fail: { error in
                        fail(error)
                })
            } else {
                fail(NSError(domain: "", code: 0, userInfo: nil))
            }
        }
    }
    
    func getAllParkingByUser(userId: String, success:([Topic] -> Void), failure:(NSError -> Void)) {
        let query = PFQuery(className: Constants.Table.Topic)
        query.includeKey(Topic.PKParking)
        
        let user = PFObject(withoutDataWithClassName: Constants.Table.User, objectId: userId)
        query.whereKey(Topic.PKPostUser, equalTo: user)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            print("User count: \(objects?.count)")
            print("Error: \(error)")
            
            if let error = error {
                failure(error)
            } else if let objs = objects {
                var topics = [Topic]()
                for pfobj in objs {
                    let topic = Topic(pfObject: pfobj)
                    topics.append(topic)
                }
                success(topics)
            }
        }

    }
}
