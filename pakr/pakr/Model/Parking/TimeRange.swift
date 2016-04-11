//
//  TimeRange.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class TimeRange: NSObject {
    let openTime: Int!
    let closeTime: Int!
    
    init(openTime: Int!, closeTime: Int!) {
        self.openTime = openTime
        self.closeTime = closeTime
    }
}