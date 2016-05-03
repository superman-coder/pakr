//
//  ShowAllCommentTableViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/18/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MBProgressHUD

class ShowAllCommentTableViewController: UITableViewController {
    
    var topic: Topic!
    var comments: [Comment]?
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.respondsToSelector(Selector("edgesForExtendedLayout"))) {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
        imageView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        imageView.image = UIImage(named: "troll")
        imageView.center = CGPointMake(self.tableView.center.x, self.tableView.center.y - 100)
        self.tableView.addSubview(imageView)
        
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "ReviewTableViewCell")
        createBarRightButton()
        getAllComments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: -Private method
    func getAllComments(){
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        WebServiceFactory.getAddressService().getAllCommentsByTopic(topic.postId!, success: { (comments) in
            self.comments = comments
            self.reloadData()
        }) { (error) in
            self.reloadData()
        }
    }
    
    func reloadData(){
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        if comments?.count > 0 {
            imageView.hidden = true
        }else{
            imageView.hidden = false
        }
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReviewTableViewCell", forIndexPath: indexPath) as!ReviewTableViewCell
        cell.comment = self.comments![indexPath.row]
        cell.selectionStyle = .None
        return cell
    }
    
    //MARK: - PrivateMethod
    func createBarRightButton(){
        let rightBarButton = UIBarButtonItem(title: "Review", style: .Plain, target: self, action: #selector(ShowAllCommentTableViewController.rightBarButtonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func rightBarButtonAction(){
        let reviewCOntroler = ReviewViewController()
        reviewCOntroler.topic = topic
        reviewCOntroler.delegate = self
        self.navigationController?.pushViewController(reviewCOntroler, animated: true)
    }
}

//MARK: - extension
extension ShowAllCommentTableViewController: ReviewViewControllerDelegate{
    func DidPostReview(comment: Comment) {
        self.comments?.insert(comment, atIndex: 0)
        let insexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([insexPath], withRowAnimation: .Automatic)
        imageView.hidden = true
    }
}
