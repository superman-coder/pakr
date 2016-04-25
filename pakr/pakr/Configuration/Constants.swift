//
//  Constants.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/18/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class Constants {
    class Parse {
        static let HOST = "https://pakr-parse.herokuapp.com/parse"
        static let APP_ID = "1411993"
        static let MASTER_KEY = "1411993"
        static let DB_URL = "mongodb://pakr_hqthao:adminkdu@ds011231.mlab.com:11231/pakr-database"
    }
    
    class Table {
        static let User = "User"
        static let Post = "Post"
        static let Topic = "Topic"
        static let Parking = "Parking"
        static let Comment = "Comment"
    }
    
    class AWS {
        static let CognitoRegionType = AWSRegionType.USEast1
        static let CognitoIdentityPoolId = "us-east-1:9d85e167-0e3e-4b68-b16b-988f763d8f98"
        
        static let DefaultServiceRegionType = AWSRegionType.APSoutheast1
        static let S3BucketName = "pakr-s3"
        static let AWS_DOMAIN = "https://s3-ap-southeast-1.amazonaws.com/" + Constants.AWS.S3BucketName + "/"
    }
    
    class Color {
        static let PrimaryColor: UInt = 0xF44336
    }
    
    static let DemoMode = true
}