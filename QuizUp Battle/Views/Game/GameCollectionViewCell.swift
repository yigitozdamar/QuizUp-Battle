//
//  GameCollectionViewCell.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 3.02.2023.
//

import UIKit

protocol GameCollectionViewCellDelegate: AnyObject {
    func answerSelected(for cell: GameCollectionViewCell, with result: Bool)
    func countdownFinished(for cell: GameCollectionViewCell)
}
class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionAmount: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    var selectedAnswer: String?
    
    var questions : QuestionData!
    weak var delegate: GameCollectionViewCellDelegate?
    var timer : Timer!
    
    func startCountdown(countFired: Int) {
        var remainingTime = countFired
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if remainingTime >= 0 {
                self.timeLabel.text = String(describing: remainingTime)
                remainingTime -= 1
            } else {
                Timer.invalidate()
                self.delegate?.countdownFinished(for: self)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thirdBtn.backgroundColor = .clear
        fourthBtn.backgroundColor = .clear
        thirdBtn.isEnabled = false
        fourthBtn.isEnabled = false
    }
    
    @IBAction func selectAnswer(_ sender: UIButton){
        selectedAnswer = sender.currentTitle
        delegate?.answerSelected(for: self, with: selectedAnswer == questions.correct_answer)
        
        for button in answerButtons {
            if button.currentTitle == selectedAnswer && button.currentTitle == questions.correct_answer {
                button.backgroundColor = UIColor.green
                timer.invalidate()
                
            } else if button.currentTitle == selectedAnswer {
                button.backgroundColor = UIColor.red
                timer.invalidate()
                
            }
        }
    }
}
