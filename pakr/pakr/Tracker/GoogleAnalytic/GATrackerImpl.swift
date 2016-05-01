//
//  GATrackerImpl.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import Google

class GATrackerImpl: GATracker {
    
    let kGAScreenName = "Google_Analytic_Screen"
    
    func trackLoginFail(loginType: String) {
        
    }
    
    func trackLoginSuccess(loginType: String, user: String) {
        
    }
    
    func trackLogout(user: String) {
        
    }
    
    func trackScreen(screen: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAScreenName, value: screen)
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
}

