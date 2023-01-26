//
//  HomeViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 25.01.2023.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
        } catch  {
            return
        }
        
        
    }
    

}
