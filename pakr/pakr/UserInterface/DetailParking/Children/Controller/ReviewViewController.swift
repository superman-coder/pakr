//
//  ReviewViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ReviewViewControllerDelegate {
    func DidPostReview(comment: Comment)
}
class ReviewViewController: UIViewController {

    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var contentMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var rating: RatingControl!
    @IBOutlet weak var textFeild: UITextField!
    
    var topic: Topic!
    var delegate: ReviewViewControllerDelegate?
    var isShowKeyBoard: Bool = false
    
    override func viewDidLoad() {

        super.viewDidLoad()
        if (self.respondsToSelector(Selector("edgesForExtendedLayout"))) {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
        LayoutUtils.dropShadowView(contenView)
        registryNotifyShowKeyBoard()
        createBarRightButton()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Private Method
    func createBarRightButton(){
        let rightBarButton = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: #selector(ReviewViewController.rightBarButtonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func rightBarButtonAction(){
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let comment = Comment(userId: topic.userId, topicId: topic.postId!, content: textView.text, title: textFeild.text!, rating: rating.rating)
        WebServiceFactory.getAddressService().postComment(comment) { (comment, error) in
            if error == nil {
                if let delegate = self.delegate {
                    delegate.DidPostReview(comment!)
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.showMessage("Post Complete!", completion: { 
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }else{
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.showMessage("Post Faild!", completion:  {
                    
                })
            }

        }
    }
    
    func showMessage(message: String,completion: (() -> Void)?) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (okAction: UIAlertAction) in
            completion!()
        }
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    func registryNotifyShowKeyBoard(){
         NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ReviewViewController.keyBoardShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyBoardShow(notifycation: NSNotification){
        if !isShowKeyBoard{
            isShowKeyBoard = true
            let dic = notifycation.userInfo
            let keyboardFrame = dic![UIKeyboardFrameBeginUserInfoKey]?.CGRectValue()
            UIView .animateWithDuration(0.3) {
                self.contentMarginBottom.constant = (keyboardFrame?.size.height)! + 10 - (self.tabBarController?.tabBar.frame.size.height)!
                self.contenView .layoutIfNeeded()
            }
            
        }
    }
    
    @IBAction func endEditing(sender: UITapGestureRecognizer) {
        view.endEditing(true)
        isShowKeyBoard = false
        UIView .animateWithDuration(0.3) {
            self.contentMarginBottom.constant = 10
            self.contenView .layoutIfNeeded()
        }
    }

}

// MARK: - extension
extension ReviewViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        print(textField.text!)
    }
    
}

extension ReviewViewController:UITextViewDelegate {
    func textViewDidEndEditing(textView: UITextView) {
        print(textView.text)
    }
}