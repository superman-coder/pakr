//
//  MoreInfoViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/13/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    @IBOutlet weak var lblTransit: UILabel!
    @IBOutlet weak var lblWorkTime: UILabel!
    @IBOutlet weak var lblWebSite: UILabel!
    @IBOutlet weak var lblSpecialties: UILabel!
    
    var parking: Parking?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func closeAction(sender: AnyObject) {
    dismissViewControllerAnimated(false, completion: nil)
    }

    // MARK: - Navigation
}
