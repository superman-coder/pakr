//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

protocol AddressService {
    func getNearByParkingLotByLocation(location location: Coordinate, radius radius: Float, success:([Topic] -> Void), fail: (NSError -> Void))
}

