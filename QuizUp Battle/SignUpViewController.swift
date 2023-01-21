//
//  SignUpViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 21.01.2023.
//

import UIKit
import GoogleSignIn

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 16
        emailTextField.layer.masksToBounds = true
    }
    
 

}
