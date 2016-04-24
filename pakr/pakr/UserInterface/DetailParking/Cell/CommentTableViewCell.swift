//
//  CommentTableViewCell.swift
//  pakr
//
//  Created by nguyen trung quang on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import Alamofire

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var imgUserCm: UIImageView!
    @IBOutlet weak var lblUserNameCm: UILabel!

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
    func disPlay(urlAvata: String, name: String){
        lblUserNameCm.text = name
        self.imgUserCm.setImageWithURL(NSURL(string: urlAvata)!, placeholderImage: nil)
    }
    
    class func initSeeAllComment() ->CommentTableViewCell {
        return UINib(nibName: "CommentTableViewCell", bundle: nil).instantiateWithOwner(nil, options: nil)[2] as!CommentTableViewCell
    }
}
