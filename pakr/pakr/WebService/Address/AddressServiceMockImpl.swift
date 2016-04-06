//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

public class AddressServiceMockImpl: NSObject, AddressService {
    public func loadAddress() {
        print("mock loading address service")
    }
}
