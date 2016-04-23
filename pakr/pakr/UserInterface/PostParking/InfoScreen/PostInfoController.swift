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
    
    @IBOutlet weak var workTimeTableView: UITableView!
    @IBOutlet weak var noteWorkTime: TextField!
    
    @IBOutlet weak var contentMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var parkingInfoContainer: UIView!
    @IBOutlet weak var contentView: UIView!
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
    
    var isShowKeyBoard = false
    var keyBoardHeight : CGFloat = 0
    var currentTextField: UITextField?
    
    var arrDayOfWeek: NSArray!
    var arrOpenTime: NSArray!
    var arrCloseTime: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFields()
        setShowdow()
        registryNotifyKeyBoard()
        workTimeTableView.scrollEnabled =  false
        workTimeTableView.rowHeight = 45
        let nib = UINib(nibName: "WorkTimeTableViewCell", bundle: nil)
        workTimeTableView.registerNib(nib , forCellReuseIdentifier: "WorkTimeTableViewCell")
        initWorkTime()
    }
    //MARK - Private method
    func initWorkTime() {
        arrDayOfWeek = ["Monday","Tues","Wed","Thur","Fri","Sat","Sun"]
        arrOpenTime = ["6:00","6:00","6:00","6:00","6:00","6:00","6:00"]
        arrCloseTime = ["24:00","24:00","24:00","24:00","24:00","24:00","24:00"]
    }
    
    func configTextFields(){
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
        LayoutUtils.setUpTextField(noteWorkTime, title: "This is notes for workTime", suggestionText: "Let us know more")
        
        businessNameTextField.delegate = self
        businessDescriptionTextField.delegate = self
        businessTelephoneTextField.delegate = self
        parkingNameTextField.delegate = self
        parkingAddressTextField.delegate = self
        parkingDescriptionTextField.delegate = self
        bikeMinPriceTextField.delegate = self
        bikeMaxPriceTextField.delegate = self
        motorMinPriceTextField.delegate = self
        motorMaxPriceTextField.delegate = self
        carMinPriceTextField.delegate = self
        carMaxPriceTextField.delegate = self
        noteWorkTime.delegate = self
    }
    func registryNotifyKeyBoard(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(PostInfoController.keyBoardShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(PostInfoController.keyBoardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyBoardShow(notifycation: NSNotification){
        if !isShowKeyBoard{
            isShowKeyBoard = true
            let dic = notifycation.userInfo
            let keyboardFrame = dic![UIKeyboardFrameBeginUserInfoKey]?.CGRectValue()
            if keyBoardHeight == 0.0 {
                keyBoardHeight = (keyboardFrame?.size.height)!
            }
            UIView .animateWithDuration(0.3) {
                self.contentMarginBottom.constant = (keyboardFrame?.size.height)! - 50
                self.contentView .layoutIfNeeded()
            }
            focusScrollViewWhenShowKeyBoard(currentTextField!)
        }
    }
    func keyBoardHide(notifycation: NSNotification){
        if isShowKeyBoard{
            isShowKeyBoard = false
            UIView .animateWithDuration(0.3) {
                self.contentMarginBottom.constant = 5
                self.contentView .layoutIfNeeded()
            }
            
        }
    }

     func setShowdow() {
        LayoutUtils.dropShadowView(businessInfoContainer)
        LayoutUtils.dropShadowView(parkingInfoContainer)
        LayoutUtils.dropShadowView(bikeDetailContainer)
        LayoutUtils.dropShadowView(motorbikeDetailContainer)
        LayoutUtils.dropShadowView(carDetailContainer)
        LayoutUtils.dropShadowView(parkingDetailContainer)
    }
    func focusScrollViewWhenShowKeyBoard(textField: UITextField){
        focusCoordinates(textField)
    }
    func focusCoordinates(textField: UITextField){
        let contentViewVisuableHeight = UIScreen.mainScreen().bounds.size.height - (self.navigationController?.navigationBar.bounds.size.height)! - 20 - keyBoardHeight
        // 100 is height of stepView config in PostParkingViewController
        var pointY = textField.bounds.size.height + textField.frame.origin.y + 100
        var viewSuper = textField.superview
        while (!viewSuper!.isKindOfClass(UIScrollView)){
            pointY = pointY + (viewSuper?.frame.origin.y)!
            viewSuper = viewSuper!.superview
        }
        print(pointY)
        print(contentViewVisuableHeight)
        print(pointY - scrollView.contentOffset.y)
        if contentViewVisuableHeight - (pointY - scrollView.contentOffset.y) <= 0 {
            isShowKeyBoard = false
             scrollView.contentOffset = CGPointMake(0, pointY - contentViewVisuableHeight + 15)
            isShowKeyBoard = true
        }
    }

}
extension PostInfoController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        currentTextField = textField
        return true
    }
}
extension PostInfoController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isShowKeyBoard{
            isShowKeyBoard = false
            UIView .animateWithDuration(0.3) {
                self.contentMarginBottom.constant = 5
                self.contentView.layoutIfNeeded()
            }
            self.view.endEditing(true)
        }
    }
}
extension PostInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkTimeTableViewCell", forIndexPath: indexPath) as! WorkTimeTableViewCell
        cell.disPlay(arrDayOfWeek[indexPath.row] as! String, closeTime:arrCloseTime[indexPath.row] as! String , openTime: arrOpenTime[indexPath.row] as! String)
        return cell
    }
}