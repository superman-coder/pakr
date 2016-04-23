//
//  ReviewViewController.swift
//  pakr
//
//  Created by nguyen trung quang on 4/17/16.
//  Copyright © 2016 Pakr. All rights reserved.
//

import UIKit

protocol ReviewViewControllerDelegate {
    func DidPostReview(rating: Int, title: String, content: String)
}
class ReviewViewController: UIViewController {

    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var contentMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var textFeild: UITextField!
    
    var delegate: ReviewViewControllerDelegate?
    var isShowKeyBoard: Bool = false
    
    override func viewDidLoad() {

        super.viewDidLoad()
        if (self.respondsToSelector(Selector("edgesForExtendedLayout"))) {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
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
        if let delegate = self.delegate {
            delegate.DidPostReview(1, title: textFeild.text!, content: textView.text)
        }
        self.navigationController?.popViewControllerAnimated(true)
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
                self.contentMarginBottom.constant = (keyboardFrame?.size.height)! + 1
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