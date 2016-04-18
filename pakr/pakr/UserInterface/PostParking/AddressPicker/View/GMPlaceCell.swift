//
//  GMPlaceCell.swift
//  pakr
//
//  Created by Tien on 4/18/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class GMPlaceCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configWithName(name:String, address:String) {
        nameLabel.text = name
        addressLabel.text = address
    }
    
}
