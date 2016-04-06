//
// Created by Huynh Quang Thao on 4/5/16.
// Copyright (c) 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class ParkingListController: UIViewController {
    
    public var addressService: AddressService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressService.loadAddress()
    }
}
