//
//  ProfileViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import SETabView
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase
import GoogleMobileAds

class ProfileViewController: UIViewController, SETabItemProvider, GADBannerViewDelegate {
    
    @IBOutlet weak var totalScoreLbl: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var avatarPic: UIButton!
    
    var gender: String = ""
    var userID = ""
    let databaseRef = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var bannerView: GADBannerView!
    
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = SecretKey.adsKey
         bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        score()
      
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      // Add banner to view and add constraints as above.
      addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
       bannerView.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(bannerView)
       view.addConstraints(
         [NSLayoutConstraint(item: bannerView,
                             attribute: .bottom,
                             relatedBy: .equal,
                             toItem: bottomLayoutGuide,
                             attribute: .top,
                             multiplier: 1,
                             constant: view.bounds.height > 667 ? -30 : 0),
          NSLayoutConstraint(item: bannerView,
                             attribute: .centerX,
                             relatedBy: .equal,
                             toItem: view,
                             attribute: .centerX,
                             multiplier: 1,
                             constant: 0)
         ])
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
            GIDSignIn.sharedInstance.signOut()
            performSegue(withIdentifier: "toLoginVC", sender: nil)
        }catch{
            print("logout hata")
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        saveToDb()
        userNameTextField.resignFirstResponder()
        let alert = UIAlertController(title: "", message: "Your settings have been changed succesfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
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

//MARK: - Update User Settings

extension ProfileViewController{
    func score() {
        
        if Auth.auth().currentUser?.uid != nil {
            self.userID = Auth.auth().currentUser?.uid ?? ""
        } else {
            self.userID = GIDSignIn.sharedInstance.currentUser?.userID ?? ""
        }
        
        let userRef = databaseRef.child("Users").child(self.userID)
        userRef.observeSingleEvent(of: .value) { [weak self] snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let score = userData["TotalScore"] as? Int, let name = userData["User"] as? String, let gender = userData["gender"] as? String{
                    self?.totalScoreLbl.text = score.description
                    self?.userNameTextField.text = name
                    self?.gender = gender
                    if gender == "female" {
                        self?.avatarPic.setImage(UIImage(named: "woman"), for: .normal)
                        self?.avatarPic.backgroundColor = UIColor(red: 0.882, green: 0.765, blue: 0.863, alpha: 1.0)
                    }
                    UserDefaults.standard.set(name, forKey: "name")
                }
            } else {
                print("hata var")
                var username = UserDefaults().object(forKey: "name") as? String
                // User does not exist, create new user entry with userID as key
                let dict : [String: Any] = ["User": username ?? "Anonymous" , "TotalScore": 0, "time": Date().timeIntervalSince1970, "gender": self?.gender ?? "male"]
                userRef.setValue(dict) { error, ref in
                    if let error = error {
                        print("Error adding new user: \(error.localizedDescription)")
                    } else {
                        print("New user added successfully.")
                    }
                }

            }
        }
    }
    
    func saveToDb() {
        UserDefaults.standard.removeObject(forKey: "name")
        if Auth.auth().currentUser?.uid != nil {
            self.userID = Auth.auth().currentUser?.uid ?? ""
        } else {
            self.userID = GIDSignIn.sharedInstance.currentUser?.userID ?? ""
        }
        let databaseRef = Database.database(url: "https://quizup-battle-default-rtdb.europe-west1.firebasedatabase.app").reference()
        let userRef = databaseRef.child("Users").child(userID)
        userRef.observeSingleEvent(of: .value) { [weak self] snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any]{
                    // User already exists, update TotalScore field
                    let childUpdates = ["User": (self?.userNameTextField.text ?? "") == "" ? "Player\(Int.random(in: 0...1000))" : self?.userNameTextField.text!, "gender": self?.gender]
                    UserDefaults().set(self?.userNameTextField.text!, forKey: "name")
                    userRef.updateChildValues(childUpdates) { error, ref in
                        if let error = error {
                            print("Error updating user data: \(error.localizedDescription)")
                        } else {
                            print("User data updated successfully.")
                        }
                    }
                }
            }
        }
    }
}

