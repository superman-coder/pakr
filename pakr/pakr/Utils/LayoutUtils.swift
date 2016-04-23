//
//  LayoutUtils.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/12/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import Material

class LayoutUtils {
    
    static func setUpTextField(textField: TextField!, title: String!, suggestionText: String!) {
        // text when first seen textfield
        textField.placeholder = title
        textField.placeholderTextColor = MaterialColor.grey.darken1
        
        // set up label
        textField.detailLabel = UILabel()
        textField.detailLabel!.font = RobotoFont.mediumWithSize(20)
        textField.detailLabel!.text = suggestionText
        textField.detailLabelAutoHideEnabled = true
        
        // user typing text
        textField.font = RobotoFont.regularWithSize(14)
        textField.textColor = MaterialColor.grey.darken1
        textField.titleLabelColor = MaterialColor.grey.base
        textField.titleLabelActiveColor = MaterialColor.blue.accent3

        textField.detailLabelActiveColor = MaterialColor.red.accent3
    }
    
    static func dropShadowView(view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
    }
}