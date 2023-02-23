//
//  ResultGameViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 9.02.2023.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class ResultGameViewController: UIViewController {
    
    var ref: DatabaseReference!
    var user = UserDefaults().object(forKey: "name") ?? "Noname" as! String
    let googleUser: GIDGoogleUser? = GIDSignIn.sharedInstance.currentUser
    var userID = ""
    
    @IBOutlet var cupAnimationView: LottieAnimationView!
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    var filterCat: [Category] = []
    var result: Int = 0
    var questionDifficulty: String = ""
    var totalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupAnimation()
        self.cupAnimationView.play()
        self.cupAnimationView.loopMode = .loop
        scoreCalculate()
        correctAnswerLabel.text = "\(result)"
        scoreLabel.text = "\(totalScore)"
    }
    
    @IBAction func returnHomeTapped(_ sender: UIButton) {
        self.cupAnimationView.stop()
        // saveToDb()
        RankingsManager.shared.saveScore(name: self.user as! String, score: self.totalScore)
        let launchScreen = LaunchViewController()
        launchScreen.modalPresentationStyle = .fullScreen
        self.present(launchScreen, animated: true, completion: nil)
        
    }
    
    @IBAction func restartGameTapped(_ sender: UIButton) {
        //saveToDb()
        RankingsManager.shared.saveScore(name: self.user as! String, score: self.totalScore)
        self.performSegue(withIdentifier: "toSettingsVC", sender: self)
    }
    
    func scoreCalculate() {
        switch questionDifficulty {
        case "easy":
            totalScore = result * 1
        case "medium":
            totalScore = result * 2
        case "hard":
            totalScore = result * 3
        default:
            break
        }
    }
}
//    func saveToDb() {
//
//        if googleUser?.userID != nil {
//            self.userID = self.googleUser?.userID ?? ""
//        } else {
//            self.userID = Auth.auth().currentUser?.uid ?? ""
//        }
//
//        let databaseRef = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference()
//        let userRef = databaseRef.child("Users").child(self.userID)
//        userRef.observeSingleEvent(of: .value) { snapshot in
//            if snapshot.exists() {
//                if let userData = snapshot.value as? [String: Any], let totalScore = userData["TotalScore"] as? Int{
//                    // User already exists, update TotalScore field
//
//                    let childUpdates = ["TotalScore": (totalScore + self.totalScore)]
//                    userRef.updateChildValues(childUpdates) { error, ref in
//                        if let error = error {
//                            print("Error updating user data: \(error.localizedDescription)")
//                        } else {
//                            print("User data updated successfully.")
//                        }
//                    }
//                }
//
//            } else {
//                // User does not exist, create new user entry with userID as key
//                let dict : [String: Any] = ["User": self.user, "TotalScore": self.totalScore, "time": Date().timeIntervalSince1970, "gender": "male"]
//                userRef.setValue(dict) { error, ref in
//                    if let error = error {
//                        print("Error adding new user: \(error.localizedDescription)")
//                    } else {
//                        print("New user added successfully.")
//                    }
//                }
//            }
//            UserDefaults.standard.set(self.totalScore, forKey: "totalScore")
//            print("Saved to FB")
//            print("Snapshot value: \(snapshot.value ?? "nil")")
//        }
//    }






