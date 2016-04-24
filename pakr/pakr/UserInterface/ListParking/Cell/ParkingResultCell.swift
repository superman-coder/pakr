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
        
        // Setup price
        priceLabel.text = "\(parking.vehicleList[0].minPrice) - \(parking.vehicleList[0].maxPrice)"
        
        // Setup schedule 
        let todaySchedule = getTodaySchedule(parking)
        scheduleLabel.text = "\(todaySchedule.open) - \(todaySchedule.close)"
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
