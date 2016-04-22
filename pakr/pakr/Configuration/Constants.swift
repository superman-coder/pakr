//
//  Constants.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/18/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

class Constants {
    
    class AWS {
        static let CognitoRegionType = AWSRegionType.USEast1
        static let CognitoIdentityPoolId = "us-east-1:9d85e167-0e3e-4b68-b16b-988f763d8f98"
        
        static let DefaultServiceRegionType = AWSRegionType.APSoutheast1
        static let S3BucketName = "pakr-s3"
        static let AWS_DOMAIN = "https://s3-ap-southeast-1.amazonaws.com/" + Constants.AWS.S3BucketName + "/"
      
    }
}