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
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func googleSignUp(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            print("Oldu")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func facebookSignUp(_ sender: Any) {
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return  }
        guard let passwordText = password.text else { return  }
        guard let passwordText2 = confirmPassword.text else { return  }
        
        if passwordText == passwordText2 {
            Auth.auth().createUser(withEmail: email, password: passwordText) {[weak self] authResult, error in
                
                if error != nil{
                    let err = error as! NSError
                    
                    switch err.code{
                            
                        case AuthErrorCode.wrongPassword.rawValue:
                            
                            print("Wrong Password")
                        case AuthErrorCode.invalidEmail.rawValue:
                        self?.errorMessage()
                            print("Wrong email")
                            
                        case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                            print("account exists")
                            
                        case AuthErrorCode.emailAlreadyInUse.rawValue:
                        self?.sameEmail()
                            print("email already in use")
                        default:
                            print("arrr:")
                    }
                    
                } else {
                    self?.emailTextField.text = ""
                    self?.password.text = ""
                    self?.confirmPassword.text = ""
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                    self?.navigationController?.pushViewController(vc, animated: true)
                    print("done")
                }
            }
            
        }else {
            print("şiflers uyusmuyoır")
        }
        
        
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func sameEmail(){
        let ac = UIAlertController(title: "Kayıtlı Email", message: "Bu email zaten kayıtlı", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    func errorMessage(){
        let ac = UIAlertController(title: "Geçersiz E-Mail", message: "Geçerli bir mail giriniz!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
 
}
