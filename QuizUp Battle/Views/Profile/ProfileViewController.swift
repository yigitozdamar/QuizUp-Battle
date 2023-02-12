//
//  ProfileViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import SETabView
import FirebaseAuth

class ProfileViewController: UIViewController, SETabItemProvider {
    
    var seTabBarItem: UITabBarItem? {
            return UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 0)
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }catch{
            print("logout hata")
        }
    }
   
    

}
