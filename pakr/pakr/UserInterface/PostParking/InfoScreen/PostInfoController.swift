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
protocol PostInfoControllerDelegate {
    func nextStep(parking :Parking)
}

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
    @IBOutlet weak var capacityTextField: TextField!
    
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
    
    func initDemoData() {
        businessNameTextField.text = "Pakr Company"
        businessDescriptionTextField.text = "We are superman. We can keep safe your vehicle. Anytime, anywhere"
        businessTelephoneTextField.text = "08-03-01676029814"
        parkingNameTextField.text = "Bãi giữ xe Hồ Con Rùa"
        parkingAddressTextField.text = "138 Hai Bà Trưng"
        parkingDescriptionTextField.text = "Đội ngũ giữ xe chuyên nghiệp thành phố"
        capacityTextField.text = "200"
        noteWorkTime.text = "Chúng tôi làm việc cả ngày nghỉ cuối tuần"
        bikeMinPriceTextField.text = "2000"
        bikeMaxPriceTextField.text = "4000"
        motorMinPriceTextField.text = "3000"
        motorMaxPriceTextField.text = "10000"
        carMinPriceTextField.text = "30000"
        carMaxPriceTextField.text = "80000"
        carCheckBox.on = true
        motorCheckBox.on = true
        bikeCheckBox.on = true
    }
    
    let value: Int = 1
    
    var isShowKeyBoard = false
    var keyBoardHeight : CGFloat = 0
    var currentTextField: UITextField?
    var message: String!
    
    var arrDayOfWeek: NSArray!
    var arrTimeRange: NSMutableArray!
    
    var currentCellSelect : WorkTimeTableViewCell!
    var isCloseTimeAction : Bool!
    
    var delegate: PostInfoControllerDelegate?
    var isSelfShow: Bool = true

    var parking: Parking?
    override func viewDidLoad() {
        super.viewDidLoad()
        carCheckBox.tintColor = UIColor.redColor()
        carCheckBox.onCheckColor = UIColor.redColor()
        // carCheckBox.onFillColor = UIColor.redColor()
        
        configTextFields()
        setShowdow()
        registryNotifyKeyBoard()
        workTimeTableView.scrollEnabled =  false
        workTimeTableView.rowHeight = 45
        self.contentView.backgroundColor = UIColor.UIColorFromRGB(0xE0E0E0)
        let nib = UINib(nibName: "WorkTimeTableViewCell", bundle: nil)
        workTimeTableView.registerNib(nib , forCellReuseIdentifier: "WorkTimeTableViewCell")
        initWorkTime()
        // init data for demo.
        initDemoData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        setDataForParking()
        isSelfShow = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        isSelfShow = false
    }
    //MARK - Private method
    func isNextStep() -> Bool {
        let mutableArray = NSMutableArray()
        mutableArray.addObject(businessNameTextField)
        mutableArray.addObject(businessDescriptionTextField)
        mutableArray.addObject(businessTelephoneTextField)
        
        mutableArray.addObject(parkingNameTextField)
        mutableArray.addObject(parkingAddressTextField)
        mutableArray.addObject(parkingDescriptionTextField)
        
        mutableArray.addObject(capacityTextField)
        
        if bikeCheckBox.on {
            mutableArray.addObject(bikeMinPriceTextField)
            mutableArray.addObject(bikeMaxPriceTextField)
        }
        if motorCheckBox.on {
            mutableArray.addObject(motorMinPriceTextField)
            mutableArray.addObject(motorMaxPriceTextField)
        }
        if carCheckBox.on {
            mutableArray.addObject(carMinPriceTextField)
            mutableArray.addObject(carMaxPriceTextField)
        }
        
        for textField in mutableArray {
            let string  = (textField as! TextField).text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if (string == "") {
                showMessage(textField as! TextField)
                return false
            }
        }
        return true
    }
    
    func showMessage(textField: TextField){
        switch textField {
        case businessNameTextField:
            message = "Please Insert Company Name"
        case businessDescriptionTextField:
            message = "Please Insert Company Decription"
        case businessTelephoneTextField:
            message = "Please Insert Company TelePhone"
        case parkingNameTextField:
            message = "Please Insert Parking Name"
        case parkingAddressTextField:
            message = "Please Insert Parking Address"
        case parkingDescriptionTextField:
            message = "Please Insert Parking Decription"
        case capacityTextField:
            message = "Please Insert Parking  Capacity"
        case bikeMinPriceTextField:
            message = "Please Insert Bike Min Price"
        case bikeMaxPriceTextField:
            message = "Please Insert Bike Max Price"
        case motorMinPriceTextField:
            message = "Please Insert Motor Min Price"
        case motorMaxPriceTextField:
            message = "Please Insert Motor Max Price"
        case carMinPriceTextField:
            message = "Please Insert Car Min Price"
        case carMaxPriceTextField:
            message = "Please Insert Car Max Price"
            break
        default:
            break
        }
        
        let alert = UIAlertController(title: "Lack of information", message: message, preferredStyle: .Alert)
        let okAction  = UIAlertAction(title:"OK", style: .Default) { (action: UIAlertAction) in
            self.dismissViewControllerAnimated(true, completion: {
                
            })
        }
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    func setDataForParking(){
        let business = Business(businessName: businessNameTextField.text, businessDescription: businessDescriptionTextField.text, telephone: businessTelephoneTextField.text)
        //        let coordinate = Coordinate(latitude: <#T##Double!#>, longitude: <#T##Double!#>)
        let vehicleList = NSMutableArray()
        if carCheckBox.on {
            let vehic = VehicleDetail(vehicleType: VehicleType.Car, minPrice: carMinPriceTextField.text, maxPrice: carMaxPriceTextField.text, note: "")
            vehicleList.addObject(vehic)
        }
        if bikeCheckBox.on {
            let vehic = VehicleDetail(vehicleType: VehicleType.Bike, minPrice: bikeMinPriceTextField.text, maxPrice: bikeMaxPriceTextField.text, note: "")
            vehicleList.addObject(vehic)
        }
        if motorCheckBox.on {
            let vehic = VehicleDetail(vehicleType: VehicleType.Motor, minPrice: motorMinPriceTextField.text, maxPrice: motorMaxPriceTextField.text, note: noteWorkTime.text)
            vehicleList.addObject(vehic)
        }
        parking = Parking(business: business, parkingName: parkingNameTextField.text, capacity: 0, addressName: parkingAddressTextField.text!, coordinate: nil, vehicleDetailList: vehicleList.copy() as! [VehicleDetail], schedule: arrTimeRange.copy() as! [TimeRange], region: [])
        dispatch_async(dispatch_get_main_queue()) {
            self.delegate?.nextStep(self.parking!)
        }
    }
    func initWorkTime() {
        arrDayOfWeek = ["Monday","Tues","Wed","Thur","Fri","Sat","Sun"]
        arrTimeRange = NSMutableArray()
        for var i = 0; i<=6 ; i += 1 {
            let time = TimeRange(openTime: "6:00", closeTime: "24:00")
            arrTimeRange.addObject(time)
        }
        workTimeTableView.reloadData()
    }
    
    func configTextFields(){
        LayoutUtils.setUpTextField(businessNameTextField, title: "Company Name", suggestionText: "Please tell us your company name")
        LayoutUtils.setUpTextField(businessDescriptionTextField, title: "Description", suggestionText: "Let us know more about you")
        LayoutUtils.setUpTextField(businessTelephoneTextField, title: "Telephone number", suggestionText: "How can we contact you")
        
        LayoutUtils.setUpTextField(parkingNameTextField, title: "Parking Name", suggestionText: "make customer easily know parking lot")
        LayoutUtils.setUpTextField(parkingAddressTextField, title: "Parking Address", suggestionText: "How can we find your parking lot")
        LayoutUtils.setUpTextField(parkingDescriptionTextField, title: "Parking Description", suggestionText: "Let us know more")
        
        LayoutUtils.setUpTextField(bikeMinPriceTextField, title: "Min Price", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(bikeMaxPriceTextField, title: "Max Price", suggestionText: "Let us know more")
        
        LayoutUtils.setUpTextField(motorMinPriceTextField, title: "Min Price", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(motorMaxPriceTextField, title: "Max Price", suggestionText: "Let us know more")
        
        LayoutUtils.setUpTextField(carMinPriceTextField, title: "Min Price", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(carMaxPriceTextField, title: "Max Price", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(noteWorkTime, title: "This is notes for workTime", suggestionText: "Let us know more")
        LayoutUtils.setUpTextField(capacityTextField, title: "This is capacity", suggestionText: "Let us know more")
        
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
        capacityTextField.delegate = self
    }
    func registryNotifyKeyBoard(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(PostInfoController.keyBoardShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(PostInfoController.keyBoardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyBoardShow(notifycation: NSNotification){
        if isSelfShow == false {
            return
        }
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
            if currentTextField != nil {
                focusScrollViewWhenShowKeyBoard(currentTextField!)
            }
        }
    }
    func keyBoardHide(notifycation: NSNotification){
        if isSelfShow == false {
            return
        }
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
    func showClockView(cell: WorkTimeTableViewCell, isCloseTime: Bool){
        currentCellSelect = cell
        isCloseTimeAction = isCloseTime
        
        let view = UIView(frame: CGRectMake(0, 0, 320, 500))
        let rootView = UIApplication.sharedApplication().keyWindow?.rootViewController
        view.center = rootView!.view.center
        
        let clockView = CustomTimePicker(view: view, withDarkTheme: false)
        clockView.backgroundColor = UIColor.blackColor()
        clockView.alpha = 0.8
        clockView.delegate = self
        rootView!.view .addSubview(clockView)
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
        cell.delegate = self
        let timeRange = arrTimeRange[indexPath.row] as! TimeRange
        cell.disPlay(arrDayOfWeek[indexPath.row] as! String, closeTime:timeRange.closeTime  , openTime: timeRange.openTime )
        return cell
    }
}
extension PostInfoController: CustomTimePickerDelegate{
    func dismissClockViewWithHours(hours: String!, andMinutes minutes: String!, andTimeMode timeMode: String!) {
        let text = "\(hours):\(minutes) \(timeMode)"
        let indexPath = workTimeTableView.indexPathForCell(currentCellSelect)
        let timeRange = arrTimeRange[indexPath!.row] as! TimeRange
        if isCloseTimeAction == true {
            currentCellSelect.lblCloseTime.text = text
            timeRange.closeTime = text
        }else{
            currentCellSelect.lblOpenTime.text = text
            timeRange.openTime = text
        }
    }
}
extension PostInfoController: WorkTimeTableViewCellDelegate{
    func didSelectOpenTimeAction(cell: WorkTimeTableViewCell) {
        showClockView(cell,isCloseTime: false)
    }
    func didSelectCloseTimeAction(cell: WorkTimeTableViewCell) {
        showClockView(cell,isCloseTime: true)
    }
}