//
//  ViewController.swift
//  Present
//
//  Created by Lucas Smith on 9/18/14.
//  Copyright (c) 2014 Volan Studio, llc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var json: NSArray = {
        let path = NSBundle.mainBundle().pathForResource("example", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        return NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray
        }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 17)
        textView.textColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.24, alpha: 1.0)
        textView.textContainerInset = UIEdgeInsetsMake(16.0, 16.0, 16.0, 16.0)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        return textView
        }()
    
    lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.backgroundColor = UIColor(hue: 200.0 / 360.0, saturation: 0.95, brightness: 0.95, alpha: 1.0)
        searchButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        return searchButton
        }()
    
    lazy var listButton: UIButton = {
        let listButton = UIButton()
        listButton.backgroundColor = UIColor(hue: 213.0 / 360.0, saturation: 0.04, brightness: 0.85, alpha: 1.0)
        listButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        return listButton
        }()
    
    lazy var viewConstraint: NSLayoutConstraint = {
        let viewConstraint = NSLayoutConstraint()
        return viewConstraint
    }()
    
    override init() {
        super.init()
        view.addSubview(textView)
        view.addSubview(searchButton)
        view.addSubview(listButton)
        
        let views = [
            "textView": textView,
            "searchButton": searchButton,
            "listButton": listButton,
        ]
        
        let metrics = [
            "margin": 12,
            "leftMargin": 16,
            "lineMargin": 14,
            "view": self.view.frame.size.height - 108.0,
            "buttonHeight": 54.0
        ]
        
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[textView]|", options: nil, metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[searchButton]|", options: nil, metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[listButton]|", options: nil, metrics: metrics, views: views))
        
        viewConstraint = NSLayoutConstraint(item: textView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -108.0)
        view.addConstraint(viewConstraint)
        
        view.addConstraint(NSLayoutConstraint(item: searchButton, attribute: .Top, relatedBy: .Equal, toItem: textView, attribute: .Bottom, multiplier: 1, constant: 0.0));
        view.addConstraint(NSLayoutConstraint(item: searchButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant:54.0));
        
        view.addConstraint(NSLayoutConstraint(item: listButton, attribute: .Top, relatedBy: .Equal, toItem: searchButton, attribute: .Bottom, multiplier: 1, constant: 0.0));
        view.addConstraint(NSLayoutConstraint(item: listButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant:54.0));
    
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Present"
        self.view.backgroundColor = UIColor.whiteColor()
        
        searchButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        textView.becomeFirstResponder()
        
        
        if let day = json[0] as? NSDictionary {
            if let title = day["title"] as? NSString {
                textView.text = title
            }
        }
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    
    // MARK: Button Functions
    
    func pressed(sender: UIButton!) {
        textView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextView!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textViewShouldReturn(textArea: UITextView!) -> Bool
    {
        textArea.resignFirstResponder()
        return true;
    }
    
    
    
    // MARK: Keyboard Event Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        NSLog("willShow")
        
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        var duration: NSTimeInterval = (info[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        
        self.viewConstraint.constant = -keyboardFrame.height - searchButton.frame.size.height - listButton.frame.size.height
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        NSLog("willHide")
    }
    
    func keyboardWillChangeFrame(notification: NSNotification) {
        NSLog("willChangeFrame")
        
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        var duration: NSTimeInterval = (info[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
        
        self.viewConstraint.constant = -searchButton.frame.size.height - listButton.frame.size.height
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }


}

