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
    
    func logout(){
        print("basıldı")
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "hometoborad", sender: nil)
            
        }catch{
            print("logout hata")
        }
    }
    

}
