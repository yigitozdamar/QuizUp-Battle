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
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                print("Error signing in with Google: \(error!.localizedDescription)")
                return
            }
            
            guard let idToken = signInResult?.user.idToken, let accessToken = signInResult?.user.accessToken else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            
            
            Auth.auth().signIn(with: credential) { authResult, error in
                guard error == nil else {
                    print("Error signing in with Firebase: \(error!.localizedDescription)")
                    return
                }
                
                // If sign in succeeded with Firebase, display the app's main content view.
                UserDefaults.standard.set(signInResult?.user.profile?.name, forKey: "name")
                self.performSegue(withIdentifier: "toLaunchVC", sender: nil)
            }
        }
    }
    
    @IBAction func policyBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return  }
        guard let passwordText = password.text else { return  }
        guard let passwordText2 = confirmPassword.text else { return  }
        
        if passwordText == passwordText2 {
            Auth.auth().createUser(withEmail: email, password: passwordText) { [weak self] authResult, error in
                
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
                            print(err.localizedDescription)
                    }
                    
                } else {
                    self?.performSegue(withIdentifier: "toLaunchVCfromRegister", sender: nil)
                    UserDefaults().set(email.components(separatedBy: "@")[0], forKey: "name")
                }
            }
            
        }else {
            print("şifreler uyusmuyoır")
        }
        
        
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        self.performSegue(withIdentifier: "boardingSignUp", sender: nil)
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
