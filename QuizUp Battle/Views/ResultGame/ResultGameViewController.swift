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
import GoogleMobileAds

class ResultGameViewController: UIViewController , GADFullScreenContentDelegate {
    
    var ref: DatabaseReference!
    var user = UserDefaults().object(forKey: "name") as? String
    
    @IBOutlet var cupAnimationView: LottieAnimationView!
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    var filterCat: [Category] = []
    var result: Int = 0
    var questionDifficulty: String = ""
    var totalScore: Int = 0
    
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cupAnimationView.play()
        self.cupAnimationView.loopMode = .loop
        scoreCalculate()
        correctAnswerLabel.text = "\(result)"
        scoreLabel.text = "\(totalScore)"
        googleAds()
        
    }
    
    @IBAction func returnHomeTapped(_ sender: UIButton) {
        self.cupAnimationView.stop()
        saveToDb()
        //TODO: Google ads implementation
        
        if self.interstitial != nil {
            self.interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
        let launchScreen = LaunchViewController()
        launchScreen.modalPresentationStyle = .fullScreen
        self.present(launchScreen, animated: true, completion: nil)
        
    }
    
    @IBAction func restartGameTapped(_ sender: UIButton) {
        saveToDb()
        //TODO: Google ads implementation
        
        if self.interstitial != nil {
            self.interstitial?.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
        }
        
        
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
        
        if Auth.auth().currentUser?.uid != nil {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let databaseRef = Database.database(url: "https://quizup-battle-default-rtdb.europe-west1.firebasedatabase.app").reference()
            let userRef = databaseRef.child("Users").child(userID)
            userRef.observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    if let userData = snapshot.value as? [String: Any], let totalScore = userData["TotalScore"] as? Int{
                        // User already exists, update TotalScore field
                        
                        let childUpdates = ["TotalScore": (totalScore + self.totalScore), "time": Date().timeIntervalSince1970 ]
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
                    let dict : [String: Any] = ["User": self.user, "TotalScore": self.totalScore, "time": Date().timeIntervalSince1970, "gender": "male"]
                    userRef.setValue(dict) { error, ref in
                        if let error = error {
                            print("Error adding new user: \(error.localizedDescription)")
                        } else {
                            print("New user added successfully.")
                        }
                    }
                }
                UserDefaults.standard.set(self.totalScore, forKey: "totalScore")
                print("Saved to FB")
                print("Snapshot value: \(snapshot.value ?? "nil")")
            }
        }
        
        
       
    }
    
    func googleAds() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:SecretKey.interstatialKey,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        }
        )
        
        /// Tells the delegate that the ad failed to present full screen content.
        func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
            print("Ad did fail to present full screen content.")
        }
        
        /// Tells the delegate that the ad will present full screen content.
        func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
            print("Ad will present full screen content.")
        }
        
        /// Tells the delegate that the ad dismissed full screen content.
        func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
            print("Ad did dismiss full screen content.")
        }
    }
 
}





