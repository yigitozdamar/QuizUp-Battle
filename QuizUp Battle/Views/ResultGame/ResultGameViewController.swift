//
//  ResultGameViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 9.02.2023.
//

import UIKit
import Lottie
import FirebaseDatabase

class ResultGameViewController: UIViewController {
    
    var ref: DatabaseReference!
    var user = UserDefaults().object(forKey: "name") ?? "Noname"
    
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
        let launchScreen = LaunchViewController()
        launchScreen.modalPresentationStyle = .fullScreen
        self.present(launchScreen, animated: true, completion: nil)
        saveToDb()
      }
    
    @IBAction func restartGameTapped(_ sender: UIButton) {
        saveToDb()
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
    
    func saveToDb() {
        let databaseRef = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference()
        let query = databaseRef.child("Users").queryOrdered(byChild: "User").queryEqual(toValue: user).queryLimited(toFirst: 1)
        query.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists(), let child = snapshot.children.first as? DataSnapshot {
                let key = child.key
                let childUpdates = ["Users/\(key)/TotalScore": self.totalScore]
                databaseRef.updateChildValues(childUpdates) { error, ref in
                    if let error = error {
                        print("Error updating user data: \(error.localizedDescription)")
                    } else {
                        print("User data updated successfully.")
                    }
                }
            } else {
                let dict : [String: Any] = ["User": self.user, "TotalScore": self.totalScore, "time": Date().timeIntervalSince1970]
                let newRef = databaseRef.child("Users").childByAutoId()
                newRef.setValue(dict) { error, ref in
                    if let error = error {
                        print("Error adding new user: \(error.localizedDescription)")
                    } else {
                        print("New user added successfully.")
                        print(dict)
                    }
                }
            }
            UserDefaults.standard.set(self.totalScore, forKey: "totalScore")
            print("Saved to FB")
            print("Snapshot value: \(snapshot.value ?? "nil")")
            print("Query matched \(snapshot.childrenCount) child/children")
        }
    }


}





