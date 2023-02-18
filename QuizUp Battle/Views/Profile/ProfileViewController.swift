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
    @IBOutlet weak var avatarPic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func genderType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0 :
            maleType()
        case 1:
            femaleType()
        default:
            print("hata")
        }
    }
    override func viewDidLayoutSubviews() {
        avatarPic.layer.cornerRadius = 0.5 * avatarPic.bounds.size.width
        avatarPic.clipsToBounds = true
    }
    
    func maleType(){
        avatarPic.setImage(UIImage(named: "man"), for: .normal)
        avatarPic.backgroundColor = UIColor(red: 0.698, green: 0.804, blue: 0.882, alpha: 1.0)
    }
    
    func femaleType(){
        avatarPic.setImage(UIImage(named: "woman"), for: .normal)
        avatarPic.backgroundColor = UIColor(red: 0.882, green: 0.765, blue: 0.863, alpha: 1.0)
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }catch{
            print("logout hata")
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
    }
    
}

