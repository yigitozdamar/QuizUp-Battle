//
//  ForgotPasswordViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 20.02.2023.
//

import UIKit
import FirebaseAuth
import GoogleMobileAds

class ForgotPasswordViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var backImage: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        backImage.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        resetButton.isEnabled = false
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
       
    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      // Add banner to view and add constraints as above.
      addBannerViewToView(bannerView)
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
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
