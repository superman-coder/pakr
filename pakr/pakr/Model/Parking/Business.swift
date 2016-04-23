//
//  Business.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class Business: NSObject, ParseNestedObjectProtocol {
    
    /// Private constants
    let PKBusinessName = "business_name"
    let PKBusinessDesc = "business_desc"
    let PKBusinessPhone = "business_phone"
    
    let businessName: String!
    let businessDescription: String!
    let telephone: String!
    
    init(businessName: String!, businessDescription: String!, telephone: String!) {
        self.businessName = businessName
        self.businessDescription = businessDescription
        self.telephone = telephone
    }
    
    required init(dict: NSDictionary) {
        self.businessName = dict[PKBusinessName] as! String
        self.businessDescription = dict[PKBusinessDesc] as! String
        self.telephone = dict[PKBusinessPhone] as! String
    }
    
    func toDictionary() -> NSDictionary {
        var dict: [String:String] = [:]
        dict[PKBusinessName] = businessName
        dict[PKBusinessDesc] = businessDescription
        dict[PKBusinessPhone] = telephone
        return dict
    }
}
