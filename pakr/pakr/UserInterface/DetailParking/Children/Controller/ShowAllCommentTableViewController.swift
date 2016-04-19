//
//  ShowAllCommentTableViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/18/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

class ShowAllCommentTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.respondsToSelector(Selector("edgesForExtendedLayout"))) {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "ReviewTableViewCell")
        
        createBarRightButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewTableViewCell", forIndexPath: indexPath)
        return cell
    }
    
    //MARK: - PrivateMethod
    func createBarRightButton(){
        let rightBarButton = UIBarButtonItem(title: "Review", style: .Plain, target: self, action: #selector(ShowAllCommentTableViewController.rightBarButtonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func rightBarButtonAction(){
        let reviewCOntroler = ReviewViewController()
        reviewCOntroler.delegate = self
        self.navigationController?.pushViewController(reviewCOntroler, animated: true)
    }
}

//MARK: - extension
extension ShowAllCommentTableViewController: ReviewViewControllerDelegate{
    func DidPostReview(rating: Int, title: String, content: String) {
        //reloadData
    }
}
