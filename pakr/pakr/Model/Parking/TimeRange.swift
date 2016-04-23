//
//  TimeRange.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class TimeRange: NSObject {
    var openTime: String!
    var closeTime: String!
    
    init(openTime: String!, closeTime: String!) {
        self.openTime = openTime
        self.closeTime = closeTime
    }
}