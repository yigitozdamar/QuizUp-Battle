//
//  GameViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 31.01.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    var difficulty: String!
    var questionType: String!
    var questionNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1233",difficulty)
        print("1223",questionType)
        print(questionNumber)
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
