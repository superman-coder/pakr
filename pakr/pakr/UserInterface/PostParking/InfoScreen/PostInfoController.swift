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
    
    
    @IBOutlet weak var parkingNameTextField: TextField!
    @IBOutlet weak var parkingDescription: TextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // parkingNameTextField.delegate = self
        parkingNameTextField.placeholder = "Email"
        
        
        /*
         Used to display the error message, which is displayed when
         the user presses the 'return' key.
         */
        parkingNameTextField.detailLabel = UILabel()
        parkingNameTextField.detailLabel!.text = "Email is incorrect."
        parkingNameTextField.detailLabel!.font = RobotoFont.regularWithSize(12)
        parkingNameTextField.detailLabelActiveColor = MaterialColor.red.accent3
        //		emailField.detailLabelAutoHideEnabled = false // Uncomment this line to have manual hiding.
    
        parkingDescription.text = ""
    }
}