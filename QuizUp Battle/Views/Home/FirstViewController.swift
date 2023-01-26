//
//  FirstViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 26.01.2023.
//

import UIKit
import FirebaseAuth

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: UIButton) {
        print("basıldı")
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "hometoborad", sender: nil)
            
        }catch{
            print("logout hata")
        }
        
    }
    
  

}
