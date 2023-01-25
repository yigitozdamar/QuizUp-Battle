//
//  LoginVC.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 25.01.2023.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var forgotPassword: UIButton!
    @IBAction func backToBoardingBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
