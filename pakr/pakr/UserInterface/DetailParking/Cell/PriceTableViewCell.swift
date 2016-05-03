//
//  PriceTableViewCell.swift
//  pakr
//
//  Created by nguyen trung quang on 4/25/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblMinPrice: UILabel!
    @IBOutlet weak var lblMaxPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func disPlay(vehicle: VehicleDetail){
        lblMinPrice.text = vehicle.minPrice
        lblMaxPrice.text = vehicle.maxPrice
        if vehicle.vehicleType == VehicleType.Car {
            imgType.image = UIImage(named: "carPrice")
        }else if vehicle.vehicleType == VehicleType.Bike {
            imgType.image = UIImage(named: "bike")
        }else if vehicle.vehicleType == VehicleType.Motor {
            imgType.image = UIImage(named: "motorPrice")
        }
    }
}
