//
// Created by Huynh Quang Thao on 4/10/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation

class WebServiceFactory {
    static func getAddressService() -> AddressService {
        return  AddressServiceParseImpl()
    }

    static func getAuthService() -> AuthService {
        return AuthServiceImpl.sharedInstance
    }
    
    static func getGATracker() -> GATracker {
        return GATrackerImpl()
    }
    
    static func getGTMTracker() -> GTMTracker {
        return GTMTrackerImpl()
    }
}
