//
//  ParkingResultCell.swift
//  pakr
//
//  Created by Tien on 4/9/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import AFNetworking

class ParkingResultCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceCar: UILabel!
    @IBOutlet weak var priceBike: UILabel!
    @IBOutlet weak var priceMotobike: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
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
    
    func configWithTopic(topic:Topic) {
        let parking = topic.parking
        nameLabel.text = parking.parkingName
        addressLabel.text = parking.addressName
        ratingCountLabel.text = "\(topic.rating)"
        
        var bikeSet = false, carSet = false, motorSet = false
        // Setup price
        for vehicle in parking.vehicleList {
            var label: UILabel? = nil
            if vehicle.vehicleType == .Bike {
                label = priceBike
                bikeSet = true
            } else if vehicle.vehicleType == .Car {
               label = priceCar
                carSet = true
            } else if vehicle.vehicleType == .Motor {
                label = priceMotobike
                motorSet = true
            }
            
            if label != nil {
                label!.text = "\(vehicle.minPrice) - \(vehicle.maxPrice)"
            }
            if !bikeSet {
                priceBike.text = "N/A"
            }
            if !carSet {
                priceCar.text = "N/A"
            }
            if !motorSet {
                priceMotobike.text = "N/A"
            }
        }
        
        // Setup schedule 
        let todaySchedule = getTodaySchedule(parking)
        scheduleLabel.text = "\(todaySchedule.open) - \(todaySchedule.close)"
        var url :NSURL
        if parking.imageUrl?.count > 0 {
            url = NSURL(string: (parking.imageUrl?.first)!)!
        }else{
            url = NSURL(string:"")!
        }
        avatarImageView.setImageWithURL(url, placeholderImage: UIImage(named: "parkingLot"))
    }

    func getTodaySchedule(parking:Parking) -> (open: String, close: String) {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let dateComponents = calendar!.component(.Weekday, fromDate: NSDate())
        let dayIndex = (dateComponents + 5) % 7
        
        var todaySchedule: (String, String) = ("", "")
        if parking.schedule.count > dayIndex {
            todaySchedule = (parking.schedule[dayIndex].openTime, parking.schedule[dayIndex].closeTime)
        } else {
            todaySchedule = (parking.schedule[0].openTime, parking.schedule[0].closeTime)
        }
        return todaySchedule
    }
}
