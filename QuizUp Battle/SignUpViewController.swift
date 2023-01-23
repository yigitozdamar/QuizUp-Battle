//
//  SignUpViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 21.01.2023.
//

import UIKit


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 16
        emailTextField.layer.masksToBounds = true
        setup()
    }

    private func setup() {

        setupKeyboardHiding() // add
    }

    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}

extension SignUpViewController {
//    @objc func keyboardWillShow(sender: NSNotification) {
//        view.frame.origin.y = view.frame.origin.y - 200
//    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
           guard let userInfo = sender.userInfo,
                 let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                 let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = ((textBoxY - keyboardTopY / 2) / 2) * -1
            view.frame.origin.y = newFrameY
        }
       }
    
   

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    /// Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}

