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
            UserDefaults().set(signInResult?.user.profile?.name.components(separatedBy: " ")[0], forKey: "name")
            self.performSegue(withIdentifier: "toLaunchVC", sender: nil)
            
        }
    }
    
    @IBAction func forgotPasswordBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "forgotPasswordVC", sender: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return  }
        guard let password = passwordTextField.text else { return  }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as? NSError {
                
                switch error.code{
                        
                    case AuthErrorCode.operationNotAllowed.rawValue:
                        self.alert(message: error.localizedDescription)
                        print("Wrong Password")
                    case AuthErrorCode.userDisabled.rawValue:
                        self.alert(message: error.localizedDescription)

                        print("Wrong email")
                        
                    case AuthErrorCode.wrongPassword.rawValue:
                        self.alert(message: error.localizedDescription)

                        print("account exists")
                        
                    case AuthErrorCode.invalidEmail.rawValue:
                        self.alert(message: error.localizedDescription)

                        print("email already in use")
                    default:
                        self.alert(message: error.localizedDescription)

                        print("error: \(error.localizedDescription)")
                }
                
            } else {
                print("User signs in successfully")
                UserDefaults().set(email.components(separatedBy: "@")[0], forKey: "name")
                self.performSegue(withIdentifier: "toLaunchVC", sender: nil)
                print("Girildi")
            }
            
            
        }
        
    }
    
    func alert(message: String){
        let alert = UIAlertController(title: "Oppps",
                                      message: "\(message)",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
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
