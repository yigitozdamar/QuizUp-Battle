//
//  RankingsManager.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 15.02.2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

struct RankingsManager {
    static let shared = RankingsManager()
    var ref: DatabaseReference!
    let databaseRef = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference()
    let googleUser: GIDGoogleUser? = GIDSignIn.sharedInstance.currentUser

    var userID = ""
   
    func score(completion: @escaping (String, String) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
  
        let userRef = databaseRef.child("Users").child(userID)
        userRef.observeSingleEvent(of: .value) { snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let score = userData["TotalScore"] as? Int, let name = userData["User"] as? String{
                    let total = score.description
                    let textField = name.description
                    UserDefaults.standard.set(name, forKey: "name")
                    completion(total, textField)
                }
            } else {
                print("hata var")
            }
        }
    }
    
    func saveToDb(userName: String, gender: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userRef = databaseRef.child("Users").child(userID)
        userRef.observeSingleEvent(of: .value) { snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let name = userData["User"] as? String{
                    // User already exists, update TotalScore field
                    let childUpdates = ["User": (userName ?? "") == "" ? "Player\(Int.random(in: 0...1000))" : userName, "gender": gender]
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
    
    func idTest() -> String{
        var userID = ""
        if googleUser?.userID != nil {
            userID = self.googleUser?.userID ?? ""
        } else {
            userID = Auth.auth().currentUser?.uid ?? ""
        }
        return userID
    }
    
     func saveScore(name: String, score: Int) {
        let id = idTest()
        let userRef = databaseRef.child("Users").child(id)
        userRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let totalScore = userData["TotalScore"] as? Int{
                    // User already exists, update TotalScore field
                    let childUpdates = ["TotalScore": (totalScore + score)]
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
                let dict : [String: Any] = ["User": name, "TotalScore": score, "time": Date().timeIntervalSince1970, "gender": "male"]
                userRef.setValue(dict) { error, ref in
                    if let error = error {
                        print("Error adding new user: \(error.localizedDescription)")
                    } else {
                        print("New user added successfully.")
                    }
                }
            }
            UserDefaults.standard.set(score, forKey: "totalScore")
            print("Saved to FB")
            print("Snapshot value: \(snapshot.value ?? "nil")")
        }
    }
}
