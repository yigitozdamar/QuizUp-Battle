//
//  SignUpViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 21.01.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.layer.cornerRadius = 16
        emailTextField.layer.masksToBounds = true
        
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

