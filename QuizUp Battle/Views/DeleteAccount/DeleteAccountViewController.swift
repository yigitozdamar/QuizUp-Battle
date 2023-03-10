//
//  DeleteAccountViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 28.02.2023.
//

import UIKit
import SETabView
import FirebaseAuth

class DeleteAccountViewController: UIViewController, SETabItemProvider {
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(systemName: "gear"), tag: 0)
    }

    @IBAction func deleteAccount(_ sender: UIButton) {
        let alert = UIAlertController(title: "ARE YOU SURE ?",
                                      message: "If you delete the account, you will lose all your history 🥲🥲",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .default))
        alert.addAction(UIAlertAction(title: "DELETE",
                                      style: .destructive,
                                      handler: { _ in
            let user = Auth.auth().currentUser
            UserDefaults.standard.removeObject(forKey: "clear")

            user?.delete { error in
              if let error = error {
                print("user deletion failure")
              } else {
                  
                 self.performSegue(withIdentifier: "launch", sender: nil)
              }
            }
        }))
        self.present(alert, animated: true, completion: nil)
        // googlesignin delete function need to be implemente!!!
       
    }
}
