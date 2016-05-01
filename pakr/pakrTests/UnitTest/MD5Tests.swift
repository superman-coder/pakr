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
        
        continueAfterFailure = false
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNormalMD5() {
        XCTAssertEqual("", "")
    }
    
}
