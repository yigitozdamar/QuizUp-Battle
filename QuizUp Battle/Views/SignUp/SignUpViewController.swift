//
//  SignUpViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 21.01.2023.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 16
        emailTextField.layer.masksToBounds = true
        
        
        
    }
    
    @IBAction func googleSignUp(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
            print("Oldu")
            
           
          }
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

