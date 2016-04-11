//
//  PostInfoController.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/11/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit
import Material

class PostInfoController: BaseViewController {
    
    @IBOutlet weak var businessNameTextField: TextField!
    @IBOutlet weak var businessDescriptionTextField: TextField!
    @IBOutlet weak var businessTelephoneTextField: TextField!
    @IBOutlet weak var parkingNameTextField: TextField!
    @IBOutlet weak var parkingAddressTextField: TextField!
    @IBOutlet weak var parkingDescriptionTextField: TextField!
   
    @IBOutlet weak var test: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        updateTextField(businessNameTextField, placeHolder: "your company here", text: "is not correct")
//        
//        updateTextField(test, placeHolder: "hello", text: "hello thao")
    }
    
    func updateTextField(textField: TextField!, placeHolder: String!, text: String!) {
        textField.placeholder = placeHolder
        textField.placeholderTextColor = MaterialColor.grey.base
        textField.font = RobotoFont.regularWithSize(12)
        textField.textColor = MaterialColor.black
        textField.text = text

        
        textField.detailLabel = UILabel()
        textField.titleLabel!.font = RobotoFont.mediumWithSize(12)
        textField.titleLabelColor = MaterialColor.grey.base
        textField.titleLabelActiveColor = MaterialColor.blue.accent3
        
        let image = UIImage(named: "ic_close_white")?.imageWithRenderingMode(.AlwaysTemplate)
        
//        let clearButton: FlatButton = FlatButton()
//        clearButton.pulseColor = MaterialColor.grey.base
//        clearButton.pulseScale = false
//        clearButton.tintColor = MaterialColor.grey.base
//        clearButton.setImage(image, forState: .Normal)
//        clearButton.setImage(image, forState: .Highlighted)
//        
//        textField.clearButton = clearButton
       
        //textField.detailLabelActiveColor = MaterialColor.red.accent3
    }
}