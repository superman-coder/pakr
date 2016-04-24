//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class AddressServiceMockImpl: NSObject, AddressService {
    func getNearByParkingLotByLocation(latitude: Double!, longitude: Double,  radius: Double, success:([Topic] -> Void), fail: (NSError -> Void)) {
        let res = Repository.TopicRepos
        success(res)
    }
    
    func getNearByParkingByAddressName(address: String, radius: Double, success: ([Topic] -> Void), fail: (NSError -> Void)) {
        
    }
}
