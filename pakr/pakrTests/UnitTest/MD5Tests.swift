//
//  MD5Tests.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/30/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import XCTest

class MD5Tests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // don't need. suitable for UI Testing
        // continueAfterFailure = false
        
        // don't need. because we're unit test
        // XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMD5_Normal() {
        let sample = "HuynhQuangThao" as NSString
        let hash = sample.MD5()
        XCTAssertEqual(hash, "1a8ae359fb5ccd53d34a9e5ec798157f")
    }
    
    func testMD5_Empty() {
        let sample = "" as NSString
        let hash = sample.MD5()
        XCTAssertEqual(hash, "d41d8cd98f00b204e9800998ecf8427e")
    }
}
