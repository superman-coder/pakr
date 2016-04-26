//
//  PhotosCollectionViewCell.swift
//  pakr
//
//  Created by nguyen trung quang on 4/13/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func disPlay(string: String){
        let url = NSURL(string: string)
        imageView.setImageWithURL(url!, placeholderImage: nil)
    }
    
}
