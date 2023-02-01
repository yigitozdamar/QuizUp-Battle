//
//  GameViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 31.01.2023.
//

import UIKit

class GameViewController: UIViewController {
    
//    var difficulty: String!
//    var questionType: String!
//    var questionNumber: Int!
//
    var questions: [QuestionData] = []
    
    let settingsManager = SettingsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
//        settingsManager.request { result in
//            self.questions = result
//                print(self.questions)
//
//        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
