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
import AuthenticationServices
import CryptoKit


class LoginVC: UIViewController, ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var appleButton: ASAuthorizationAppleIDButton!
    fileprivate var currentNonce: String?
    
    @IBAction func backToBoardingBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "board", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        appleButton.window?.cornerRadius = 20
        appleButton.addTarget(self, action: #selector(handleAppleSignInButtonPress), for: .touchUpInside)
        
    }
    
    @objc
    func handleAppleSignInButtonPress() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential, including the user's full name.
          
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    print(error?.localizedDescription ?? "Apple login error")
                    return
                }
                // User is signed in to Firebase with Apple.
                UserDefaults.standard.set(authResult?.user.displayName, forKey: "name")
                self.performSegue(withIdentifier: "toLaunchVC", sender: nil)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Apple Fails")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
        
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
    
    @IBAction func forgotPasswordBtnTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "forgotPasswordVC", sender: nil)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text else { return  }
        guard let password = passwordTextField.text else { return  }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            if let error = error as? NSError {
                
                switch error.code{
                        
                    case AuthErrorCode.operationNotAllowed.rawValue:
                        self?.alert(message: error.localizedDescription)
                        print("Wrong Password")
                    case AuthErrorCode.userDisabled.rawValue:
                        self?.alert(message: error.localizedDescription)
                        
                        print("Wrong email")
                        
                    case AuthErrorCode.wrongPassword.rawValue:
                        self?.alert(message: error.localizedDescription)
                        
                        print("account exists")
                        
                    case AuthErrorCode.invalidEmail.rawValue:
                        self?.alert(message: error.localizedDescription)
                        
                        print("email already in use")
                    default:
                        self?.alert(message: error.localizedDescription)
                        
                        print("error: \(error.localizedDescription)")
                }
                
            } else {
                print("User signs in successfully")
                UserDefaults().set(email.components(separatedBy: "@")[0], forKey: "name")
                self?.performSegue(withIdentifier: "toLaunchVC", sender: nil)
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
}

extension LoginVC {
    
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    
    
}
