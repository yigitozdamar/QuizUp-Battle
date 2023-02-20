//
//  ProfileViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import SETabView
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, SETabItemProvider {
    
    @IBOutlet weak var totalScoreLbl: UILabel!
    var ref: DatabaseReference!
    var user = UserDefaults().object(forKey: "name") ?? "Noname"
    var gender: String = "male"
    
    @IBOutlet weak var userNameTextField: UITextField!
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 0)
    }
    @IBOutlet weak var avatarPic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score()
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
    
    @IBAction func logOutButton(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }catch{
            print("logout hata")
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        saveToDb()
    }
    
    func score(){
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference()
        let userRef = databaseRef.child("Users").child(userID)
        userRef.observeSingleEvent(of: .value) { snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let name = userData["TotalScore"] as? Int{
                    // User already exists, update TotalScore field
                    self.totalScoreLbl.text = name.description
                  
                }
                
            } else {
                
                print("hata var")
            }
     //       UserDefaults.standard.set(self.totalScore, forKey: "totalScore")
//            print("Saved to FB")
//            print("Snapshot value: \(snapshot.value ?? "nil")")
        }
    }
    
    
    
    func saveToDb() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference()
        let userRef = databaseRef.child("Users").child(userID)
        userRef.observeSingleEvent(of: .value) { snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let name = userData["User"] as? String{
                    // User already exists, update TotalScore field
                    let childUpdates = ["User": (self.userNameTextField.text ?? "") == "" ? "Player\(Int.random(in: 0...1000))" : self.userNameTextField.text!, "gender": self.gender]
                    userRef.updateChildValues(childUpdates) { error, ref in
                        if let error = error {
                            print("Error updating user data: \(error.localizedDescription)")
                        } else {
                            print("User data updated successfully.")
                        }
                    }
                }
                
            } else {
                // User does not exist, create new user entry with userID as key
                let dict : [String: Any] = ["User": self.userNameTextField.text ?? self.user, "TotalScore": 0, "time": Date().timeIntervalSince1970, "gender": "male"]
                userRef.setValue(dict) { error, ref in
                    if let error = error {
                        print("Error adding new user: \(error.localizedDescription)")
                    } else {
                        print("New user added successfully.")
                    }
                }
            }
     //       UserDefaults.standard.set(self.totalScore, forKey: "totalScore")
//            print("Saved to FB")
//            print("Snapshot value: \(snapshot.value ?? "nil")")
        }
    }
    
    
    
}



