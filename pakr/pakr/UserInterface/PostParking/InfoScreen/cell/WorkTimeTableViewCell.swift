//
//  WorkTimeTableViewCell.swift
//  pakr
//
//  Created by nguyen trung quang on 4/23/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class WorkTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var lbldayOfWeek: UILabel!

    @IBOutlet weak var lblCloseTime: UILabel!
    @IBOutlet weak var lblOpenTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editAction(sender: AnyObject) {
        print("sdfsd")
    }
    
    func disPlay(dayOfWeek: String, closeTime: String, openTime: String){
        lbldayOfWeek.text = dayOfWeek
        lblCloseTime.text = closeTime
        lblOpenTime.text = openTime
    }
    
}
