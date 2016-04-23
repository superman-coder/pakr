//
//  TimeRange.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class TimeRange: NSObject, ParseNestedObjectProtocol {
    var openTime: String!
    var closeTime: String!
    
    let PKScheduleOpenTime = "schedule_open"
    let PKScheduleCloseTime = "schedule_close"
    
    init(openTime: String!, closeTime: String!) {
        self.openTime = openTime
        self.closeTime = closeTime
    }
    
    required init(dict: NSDictionary) {
        openTime = dict[PKScheduleOpenTime] as! String
        closeTime = dict[PKScheduleCloseTime] as! String
    }
    
    func toDictionary() -> NSDictionary {
        var dict: [String:String] = [:]
        dict[PKScheduleOpenTime] = openTime
        dict[PKScheduleCloseTime] = closeTime
        return dict
    }
}