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
    
    @IBOutlet weak var totalScoreLbl: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var avatarPic: UIButton!
    
    var gender: String = "male"
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RankingsManager.shared.score { total, textField in
            self.totalScoreLbl.text = total
            self.userNameTextField.text = textField
        }
      
        userNameTextField.text = UserDefaults().object(forKey: "name") as? String
    }
    
    @IBAction func genderType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0 :
            gender = maleType()
        case 1:
            gender = femaleType()
        default:
            print("hata")
        }
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "name")
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }catch{
            print("logout hata")
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {

        RankingsManager.shared.saveToDb(userName: self.userNameTextField.text!, gender: gender)
    }
}

//MARK: - Settings Adjustment
extension ProfileViewController{
    override func viewDidLayoutSubviews() {
        avatarPic.layer.cornerRadius = 0.5 * avatarPic.bounds.size.width
        avatarPic.clipsToBounds = true
    }
    
    func maleType()-> String{
        avatarPic.setImage(UIImage(named: "man"), for: .normal)
        avatarPic.backgroundColor = UIColor(red: 0.698, green: 0.804, blue: 0.882, alpha: 1.0)
        return "male"
    }
    
    func femaleType()-> String{
        avatarPic.setImage(UIImage(named: "woman"), for: .normal)
        avatarPic.backgroundColor = UIColor(red: 0.882, green: 0.765, blue: 0.863, alpha: 1.0)
        return "female"
    }
}



