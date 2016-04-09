//
//  ParkingResultCell.swift
//  pakr
//
//  Created by Tien on 4/9/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class ParkingResultCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.layer.cornerRadius = 8
        avatarImageView.layer.masksToBounds = true
        
        self.bgView.layer.cornerRadius = 5;
        self.bgView.layer.shadowOffset = CGSizeMake(2, 2)
        self.bgView.layer.shadowColor = UIColor.blackColor().CGColor
        self.bgView.layer.shadowRadius = 1
        self.bgView.layer.shadowOpacity = 0.25
        
        let shadowFrame = self.layer.bounds
        let shadowPath = UIBezierPath(rect: shadowFrame).CGPath
        self.layer.shadowPath = shadowPath
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
