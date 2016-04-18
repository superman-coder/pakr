//
//  PakrImageUtils.swift
//  pakr
//
//  Created by Tien on 4/16/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class PakrImageUtils: NSObject {
    class func resizeImage(image:UIImage, toSize size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size);
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
}
