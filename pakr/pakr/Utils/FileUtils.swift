//
//  FileUtils.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/22/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class FileUtils {
    static func createTemporaryDirectoryWithName(directory: String) {
        let error = NSErrorPointer()
        do {
            try NSFileManager.defaultManager().createDirectoryAtURL(
                NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(directory),
                        withIntermediateDirectories: true,
                        attributes: nil)
        } catch let error1 as NSError {
            error.memory = error1
            print("Creating 'upload' directory failed. Error: \(error)")
        }

    }
}