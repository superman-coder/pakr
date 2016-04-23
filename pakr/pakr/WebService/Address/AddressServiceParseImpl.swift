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
}
