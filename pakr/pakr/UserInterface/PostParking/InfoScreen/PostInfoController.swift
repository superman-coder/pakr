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
import BEMCheckBox

class PostInfoController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var businessNameTextField: TextField!
    @IBOutlet weak var businessDescriptionTextField: TextField!
    @IBOutlet weak var businessTelephoneTextField: TextField!
    
    @IBOutlet weak var parkingNameTextField: TextField!
    @IBOutlet weak var parkingAddressTextField: TextField!
    @IBOutlet weak var parkingDescriptionTextField: TextField!
    
    @IBOutlet weak var workStartTimeLabel: MaterialLabel!
    @IBOutlet weak var workEndTimeLabel: MaterialLabel!
    @IBOutlet weak var weekendStartTimeLabel: MaterialLabel!
    @IBOutlet weak var weekendEndTimeLabel: MaterialLabel!
    @IBOutlet weak var capacityTextField: TextField!
    @IBOutlet weak var priceDescriptionTextField: TextField!
    
    
    @IBOutlet weak var parkingInfoContainer: UIView!
    @IBOutlet weak var businessInfoContainer: UIView!
    @IBOutlet weak var bikeDetailContainer: UIView!
    @IBOutlet weak var motorbikeDetailContainer: UIView!
    @IBOutlet weak var carDetailContainer: UIView!
    @IBOutlet weak var parkingDetailContainer: UIView!
    
    @IBOutlet weak var bikeMinPriceTextField: TextField!
    @IBOutlet weak var bikeMaxPriceTextField: TextField!
    @IBOutlet weak var bikeCheckBox: BEMCheckBox!
    
    
    @IBOutlet weak var motorMinPriceTextField: TextField!
    @IBOutlet weak var motorMaxPriceTextField: TextField!
    @IBOutlet weak var motorCheckBox: BEMCheckBox!
    
    
    @IBOutlet weak var carMinPriceTextField: TextField!
    @IBOutlet weak var carMaxPriceTextField: TextField!
    @IBOutlet weak var carCheckBox: BEMCheckBox!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        LayoutUtils.setUpTextField(businessNameTextField, title: "Company Name", suggestionText: "Please tell us your company name")
        LayoutUtils.setUpTextField(businessDescriptionTextField, title: "Description", suggestionText: "Let us know more about you")
        LayoutUtils.setUpTextField(businessTelephoneTextField, title: "Telephone number", suggestionText: "How can we contact you")
        
        LayoutUtils.setUpTextField(parkingNameTextField, title: "Parking Name", suggestionText: "make customer easily know parking lot")
        LayoutUtils.setUpTextField(parkingAddressTextField, title: "Parking Address", suggestionText: "How can we find your parking lot")
        LayoutUtils.setUpTextField(parkingDescriptionTextField, title: "Parking Detail", suggestionText: "Let us know more")
        
        LayoutUtils.setUpTextField(bikeMinPriceTextField, title: "Min Price", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(bikeMaxPriceTextField, title: "Max Price", suggestionText: "Let us know more")
        
        LayoutUtils.setUpTextField(motorMinPriceTextField, title: "Min Price", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(motorMaxPriceTextField, title: "Max Price", suggestionText: "Let us know more")
 
        LayoutUtils.setUpTextField(carMinPriceTextField, title: "Min Price", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(carMaxPriceTextField, title: "Max Price", suggestionText: "Let us know more")
        
        
    }
    
    override func viewDidLayoutSubviews() {
        LayoutUtils.dropShadowView(businessInfoContainer)
        LayoutUtils.dropShadowView(parkingInfoContainer)
        LayoutUtils.dropShadowView(bikeDetailContainer)
        LayoutUtils.dropShadowView(motorbikeDetailContainer)
        LayoutUtils.dropShadowView(carDetailContainer)
        LayoutUtils.dropShadowView(parkingDetailContainer)
//        var contentRect = CGRectZero
//        for view in self.scrollView.subviews {
//            print("size: \(view.frame)")
//            contentRect = CGRectUnion(contentRect, view.frame)
//        }
//        self.scrollView.contentSize = contentRect.size
    }
    
}