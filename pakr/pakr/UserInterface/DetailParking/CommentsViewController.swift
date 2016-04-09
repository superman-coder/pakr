//
//  CommentsViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/9/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: - btnCloseAction
    @IBAction func disMissCommentViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
