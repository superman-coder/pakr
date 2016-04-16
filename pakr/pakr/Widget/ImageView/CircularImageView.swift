//
//  CircularImageView.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/16/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit


class CircularImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true;
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
}