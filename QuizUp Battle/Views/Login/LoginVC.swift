//
//  LoginVC.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 25.01.2023.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBAction func backToBoardingBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "board", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            print("Oldu")
            self.performSegue(withIdentifier: "tabbar", sender: nil)
            
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return  }
        guard let password = passwordTextField.text else { return  }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as? NSError {
                
                switch error.code{
                        
                    case AuthErrorCode.operationNotAllowed.rawValue:
                        
                        print("Wrong Password")
                    case AuthErrorCode.userDisabled.rawValue:
                        //                      self?.errorMessage()
                        print("Wrong email")
                        
                    case AuthErrorCode.wrongPassword.rawValue:
                        print("account exists")
                        
                    case AuthErrorCode.invalidEmail.rawValue:
                        //                      self?.sameEmail()
                        print("email already in use")
                    default:
                        print("error: \(error.localizedDescription)")
                }
                
            } else {
                print("User signs in successfully")
               
                self.performSegue(withIdentifier: "tabbar", sender: nil)
                print("Girildi")
            }
            
            
        }
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
    }
}
