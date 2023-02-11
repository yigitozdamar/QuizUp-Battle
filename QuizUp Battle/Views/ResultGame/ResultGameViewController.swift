//
//  ResultGameViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 9.02.2023.
//

import UIKit
import Lottie

class ResultGameViewController: UIViewController {

    @IBOutlet var cupAnimationView: LottieAnimationView!
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
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
    }
    
    @IBAction func restartGameTapped(_ sender: UIButton) {
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
