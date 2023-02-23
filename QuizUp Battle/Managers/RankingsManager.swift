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
    var userID = ""
    
    mutating func score(completion: @escaping (String, String) -> Void) {
        
        if Auth.auth().currentUser?.uid != nil {
            self.userID = Auth.auth().currentUser?.uid ?? ""
        } else {
            self.userID = GIDSignIn.sharedInstance.currentUser?.userID ?? ""
        }
  
        let userRef = databaseRef.child("Users").child(self.userID)
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
    
    mutating func saveToDb(userName: String, gender: String) {
        
        if Auth.auth().currentUser?.uid != nil {
            self.userID = Auth.auth().currentUser?.uid ?? ""
        } else {
            self.userID = GIDSignIn.sharedInstance.currentUser?.userID ?? ""
        }
        
        let userRef = databaseRef.child("Users").child(self.userID)
        userRef.observeSingleEvent(of: .value) { snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let name = userData["User"] as? String{
                    // User already exists, update TotalScore field
                    let childUpdates = ["User": name , "gender": gender]
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
    
//    func idTest() -> String{
//        var userID = ""
//        if !googleUser.isEmpty {
//            userID = self.googleUser
//        } else {
//            userID = Auth.auth().currentUser?.uid ?? ""
//        }
//        return userID
//    }
    

}
