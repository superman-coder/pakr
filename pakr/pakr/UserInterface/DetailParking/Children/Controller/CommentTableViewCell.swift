//
//  CommentTableViewCell.swift
//  pakr
//
//  Created by nguyen trung quang on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    class func initCommentsCellFromNib () ->CommentTableViewCell {
        return UINib(nibName: "CommentTableViewCell", bundle: nil).instantiateWithOwner(nil, options: nil)[1] as!CommentTableViewCell
    }
    class func initCommentCellFromNib () ->CommentTableViewCell {
        return UINib(nibName: "CommentTableViewCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as!CommentTableViewCell
    }
}
