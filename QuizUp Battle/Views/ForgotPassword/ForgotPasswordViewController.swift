//
//  ForgotPasswordViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 20.02.2023.
//

import UIKit
import FirebaseAuth


class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var backImage: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backImage.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        resetButton.isEnabled = false
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func backTapped(){
        self.dismiss(animated: true)
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                print("Error sending password reset email: \(error.localizedDescription)")
                return
            }
            
            print("Password reset email sent successfully")
            self.dismiss(animated: true)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        resetButton.isEnabled = !(textField.text?.isEmpty ?? true)
    }
    
}
