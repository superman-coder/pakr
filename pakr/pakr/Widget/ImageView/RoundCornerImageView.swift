//
//  RoundCornerImageView.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/16/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class RoundCornerImageView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true;
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
}