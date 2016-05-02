//
//  MoreInfoViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/13/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblcapacity: UILabel!
    @IBOutlet weak var lblSpecialties: UILabel!
    @IBOutlet weak var workTimeTableView: UITableView!
    @IBOutlet weak var workTimeheight: NSLayoutConstraint!
    
    @IBOutlet weak var priceTableView: UITableView!
    @IBOutlet weak var priceHeight: NSLayoutConstraint!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var specialtiesView: UIView!
    var parking: Parking?
    var arrDayOfWeek: NSArray!
    var arrTimeRange: [TimeRange]!
    var arrvehicle: [VehicleDetail]!

    override func viewDidLoad() {

        super.viewDidLoad()
        self.title = parking?.business.businessName
        LayoutUtils.dropShadowView(informationView)
        LayoutUtils.dropShadowView(specialtiesView)
        LayoutUtils.dropShadowView(priceTableView)
         LayoutUtils.dropShadowView(workTimeTableView)
        
        workTimeTableView.scrollEnabled = false
        workTimeTableView.rowHeight = 45
        let nib = UINib(nibName: "WorkTimeTableViewCell", bundle: nil)
        workTimeTableView.registerNib(nib , forCellReuseIdentifier: "WorkTimeTableViewCell")
        
        priceTableView.scrollEnabled = false
        priceTableView.rowHeight = 45
        let nib1 = UINib(nibName: "PriceTableViewCell", bundle: nil)
        priceTableView.registerNib(nib1 , forCellReuseIdentifier: "PriceTableViewCell")
//
        lblAddress.text = parking?.addressName
        lblSpecialties.text = parking?.vehicleList.first?.note
        lblcapacity.text = ("\(parking!.capacity)")
        initWorkTime()
        initVehicle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    // MARK: - Private Method
    func initWorkTime() {
        arrDayOfWeek = ["Monday","Tues","Wed","Thur","Fri","Sat","Sun"]
        arrTimeRange = parking?.schedule
        workTimeheight.constant = CGFloat(arrTimeRange.count * 45)
        workTimeTableView.reloadData()
    }
    func initVehicle() {
        arrvehicle = parking?.vehicleList
        print(arrvehicle.first!.vehicleType)
        print(arrvehicle.first!.minPrice)
        print(arrvehicle.first!.maxPrice)
        print(arrvehicle.first!.note)
        priceHeight.constant = CGFloat(arrvehicle.count * 45)
        priceTableView.reloadData()
    }
}

extension MoreInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(workTimeTableView) {
            return arrTimeRange.count ?? 0
        }else{
            return arrvehicle.count ?? 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.isEqual(workTimeTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("WorkTimeTableViewCell", forIndexPath: indexPath) as! WorkTimeTableViewCell
            let timeRange = arrTimeRange[indexPath.row]
            cell.disPlay1(arrDayOfWeek[indexPath.row] as! String, closeTime:timeRange.closeTime  , openTime: timeRange.openTime )
            cell.selectionStyle = .None
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("PriceTableViewCell", forIndexPath: indexPath) as! PriceTableViewCell
            let vehicle = arrvehicle[indexPath.row]
            cell.disPlay(vehicle)
            cell.selectionStyle = .None
            return cell
        }

    }
}
