//
//  ParseModelProxy.swift
//  pakr
//
//  Created by Tien on 4/22/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import Parse

protocol ParseModelProtocol {
    init(pfObject: PFObject)
    func toPFObject() -> PFObject
}

protocol ParseNestedObjectProtocol {
    init(dict:NSDictionary)
    func toDictionary() -> NSDictionary
}