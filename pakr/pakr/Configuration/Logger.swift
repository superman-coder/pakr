//
//  Logger.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/2/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class Logger {
    
    class func debug(message: String, filename: String = #file,
                     function: String = #function, line: Int = #line) {
        
        #if DEBUG
            print("💜[DEBUG][\(filename.lastPathComponent):\(line)] \(function) 👉 \(message)")
        #endif
    }
    
    class func info(message: String, filename: String = #file,
                    function: String = #function, line: Int = #line) {
        
        #if DEBUG
            print("💚[INFO][\(filename.lastPathComponent):\(line)] \(function) 👉 \(message)")
        #endif
    }
    
    class func warning(message: String, filename: String = #file,
                       function: String = #function, line: Int = #line) {
        
        print("💛[WARNING][\(filename.lastPathComponent):\(line)] \(function) 👉 \(message)")
    }
    
    class func dafug(message: String, filename: String = #file,
                     function: String = #function, line: Int = #line) {
        
        print("❤️[ERROR][\(filename.lastPathComponent):\(line)] \(function) 👉 \(message)")
    }
    
    class func push(message: String, filename: String = #file,
                    function: String = #function, line: Int = #line) {
        
        print("FIXME 🍓[\(filename.lastPathComponent):\(line)] \(function) 👉 \(message)")
    }
}

