//
//  ExtendedCell.swift
//  pakr
//
//  Created by Huynh Quang Thao on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import Foundation
import UIKit

class ExtendedCell: UITableViewCell {
    
    weak var _tableView: UITableView!
    
    func rowIndex() -> Int {
        if _tableView == nil {
            _tableView = tableView()
        }
        
        return _tableView.indexPathForSelectedRow!.row
    }
    
    func tableView() -> UITableView! {
        if _tableView != nil {
            return _tableView
        }
        
        var view = self.superview
        while view != nil && !(view?.isKindOfClass(UITableView))! {
            view = view?.superview
        }
        
        self._tableView = view as! UITableView
        return _tableView
    }
}
