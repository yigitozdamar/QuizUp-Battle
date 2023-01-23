//
//  SignUpViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 21.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 16
        emailTextField.layer.masksToBounds = true
        hideKeyboardWhenTappedAround()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardApperence(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var isExpand:Bool = false
    
    @objc func keyboardApperence(notification: NSNotification){
        if !isExpand{
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + keyboardHeight)
            }
            else{
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 250)
            }
            isExpand = true
        }
    }
    @objc func keyboardDisappear(notification: NSNotification){
        if isExpand{
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardHeight = keyboardFrame.cgRectValue.height
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - keyboardHeight)
            }
            else{
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 250)
            }
            isExpand = false
        }
    }
    
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
