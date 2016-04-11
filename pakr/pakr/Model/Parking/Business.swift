//
//  Business.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class Business: NSObject {
    let businessName: String!
    let businessDescription: String!
    let telephone: String!
    
    init(businessName: String!, businessDescription: String!, telephone: String!) {
        self.businessName = businessName
        self.businessDescription = businessDescription
        self.telephone = telephone
    }
}