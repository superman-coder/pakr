//
//  AllPostAdapter.swift
//  pakr
//
//  Created by Huynh Quang Thao on 5/1/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation

protocol AllPostAdapter {
   func refreshData()
    func setListener(listener: OnAllPostItemClickListener)
}

protocol OnAllPostItemClickListener: class {
    func onAllPostItemClick(order: Int)
}