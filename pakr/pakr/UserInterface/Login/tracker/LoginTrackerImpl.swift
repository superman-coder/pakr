//
//  LoginTrackerImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class LoginTrackerImpl: LoginTracker {
    
    let tracker: TrackerDelegator
    
    init() {
        tracker = WebServiceFactory.getTrackerDelegator()
    }
    
    func trackScreen() {
       tracker.trackScreen("Login Screen")
    }
}