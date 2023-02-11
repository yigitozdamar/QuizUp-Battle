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
    
    @IBOutlet weak var proggresbar: Progressbar!
    @IBOutlet weak var questionAmount: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var answerStackBottom: NSLayoutConstraint!
    var selectedAnswer: String?
    
    var questions : QuestionData!
    weak var delegate: GameCollectionViewCellDelegate?
    var countFired: CGFloat = 10
    var timer: Timer!
    
    func startCountdown() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.countFired -= 1
            DispatchQueue.main.async {
                self?.proggresbar.progress = max(self!.countFired / 10 , 0)
                
                if self?.countFired == 0 {
                    timer.invalidate()
                    self?.countFired = 11
                    
                    self?.delegate?.countdownFinished(for: self!)
                }
            }
        }
    }
    
    @IBAction func selectAnswer(_ sender: UIButton){
        selectedAnswer = sender.currentTitle
        delegate?.answerSelected(for: self, with: selectedAnswer == questions.correct_answer)
        
        for button in answerButtons {
            if button.currentTitle == selectedAnswer && button.currentTitle == questions.correct_answer {
                button.backgroundColor = UIColor.green
                timer.invalidate()
                countFired = 11
              
            } else if button.currentTitle == selectedAnswer {
                button.backgroundColor = UIColor.red
                timer.invalidate()
                countFired = 11
            
            } else {
                button.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
}
