//
//  CommonMacros.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/2/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class System {
    
    class func isiPhone() -> Bool {
        return (UIDevice.currentDevice().model  == "iPhone") ||
            (UIDevice.currentDevice().model  == "iPhone Simulator")
    }
    
    class func systemVersionEqualTo(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
                                                              options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
    }
    
    class func systemVersionGreaterThan(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
                                                              options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
    }
    
    class func systemVersionGreaterThanOrEqualTo(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
                                                              options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
    }
    
    class func systemVersionLessThan(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
                                                              options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
    }
    
    class func systemVersionLessThanOrEqualTo(version: NSString) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version as String,
                                                              options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
    }
}