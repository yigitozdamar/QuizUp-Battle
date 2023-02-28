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
        return UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 0)
    }

    @IBAction func deleteAccount(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        UserDefaults.standard.removeObject(forKey: "clear")

        user?.delete { error in
          if let error = error {
            print("user deletion failure")
          } else {
              self.performSegue(withIdentifier: "launch", sender: nil)
          }
        }
    }
}
