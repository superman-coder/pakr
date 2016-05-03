//
//  ReviewTableViewCell.swift
//  pakr
//
//  Created by nguyen trung quang on 4/19/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import AFNetworking

class ReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var timeCreateLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = 5;
        userImage.clipsToBounds = true;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var comment: Comment!{
        didSet{
            userNameLbl.text = comment.title
            ratingControl.rating = comment.rating
            contentLbl.text = comment.content
            titleLbl.text = "   "
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            let string = dateFormatter.stringFromDate(comment.dateCreated)
            timeCreateLbl.text = string
            WebServiceFactory.getAddressService().getUserById(comment.userId) { (user, error) in
                self.titleLbl.text = user?.name
                self.userImage.setImageWithURL(NSURL(string: (user?.avatarUrl)!)!, placeholderImage: UIImage(named: "parkingLot"))
            }
        }
    }
}
