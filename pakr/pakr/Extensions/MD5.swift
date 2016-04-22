//
//  MD5.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/22/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

extension NSData {
    func MD5() -> NSString {
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        let md5Buffer = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLength)
        
        CC_MD5(bytes, CC_LONG(length), md5Buffer)
        let output = NSMutableString(capacity: Int(CC_MD5_DIGEST_LENGTH * 2))
        
        //  convert to hex string
        for i in 0..<digestLength {
            output.appendFormat("%02x", md5Buffer[i])
        }
        
        return NSString(format: output)
    }
}

extension NSString {
    func MD5() -> NSString {
        let digestLength = Int(CC_MD5_DIGEST_LENGTH)
        let md5Buffer = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLength)
        CC_MD5(UTF8String, CC_LONG(strlen(UTF8String)), md5Buffer)
        
        let output = NSMutableString(capacity: Int(CC_MD5_DIGEST_LENGTH * 2))
        
        // convert to hex string
        for i in 0..<digestLength {
            output.appendFormat("%02x", md5Buffer[i])
        }
        
        return NSString(format: output)
    }
}