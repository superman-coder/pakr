//
//  UIColor+Pakr.swift
//  pakr
//
//  Created by Tien on 4/24/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func primaryColor() -> UIColor {
        return UIColorFromRGB(Constants.Color.PrimaryColor)
    }
    
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}