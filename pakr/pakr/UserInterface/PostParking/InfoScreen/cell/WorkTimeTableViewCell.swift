//
//  WorkTimeTableViewCell.swift
//  pakr
//
//  Created by nguyen trung quang on 4/23/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
protocol WorkTimeTableViewCellDelegate {
    func didSelectCloseTimeAction(cell: WorkTimeTableViewCell)
    func didSelectOpenTimeAction(cell: WorkTimeTableViewCell)
}

class WorkTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var lbldayOfWeek: UILabel!

    @IBOutlet weak var lblCloseTime: UILabel!
    @IBOutlet weak var lblOpenTime: UILabel!
    var delegate: WorkTimeTableViewCellDelegate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnOpenTimeAction(sender: AnyObject) {
        delegate!.didSelectOpenTimeAction(self)
    }
    
    @IBAction func btnCloseTimeAction(sender: AnyObject) {
        delegate!.didSelectCloseTimeAction(self)
    }
    func disPlay(dayOfWeek: String, closeTime: String, openTime: String){
        lbldayOfWeek.text = dayOfWeek
        lblCloseTime.text = closeTime
        lblOpenTime.text = openTime
    }
    
}
