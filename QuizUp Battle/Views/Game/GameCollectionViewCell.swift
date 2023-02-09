//
//  GameCollectionViewCell.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 3.02.2023.
//

import UIKit

protocol GameCollectionViewCellDelegate: AnyObject {
    func answerSelected(for cell: GameCollectionViewCell, with result: Bool)
}


class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewTop: UIImageView!
    @IBOutlet weak var questionAmount: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var circleTimer: CircleCount!
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

    
    @IBAction func selectAnswer(_ sender: UIButton){
        selectedAnswer = sender.currentTitle
        delegate?.answerSelected(for: self, with: selectedAnswer == questions.correct_answer)
        
        for button in answerButtons {
            if button.currentTitle == selectedAnswer && button.currentTitle == questions.correct_answer {
                button.backgroundColor = UIColor.green
            } else if button.currentTitle == selectedAnswer {
                button.backgroundColor = UIColor.red
            } else {
                button.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
}
