//
//  GameCollectionViewCell.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 3.02.2023.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewTop: UIImageView!
    @IBOutlet weak var questionAmount: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    var selectedAnswer: String?
    
    
    @IBAction func selectAnswer(_ sender: UIButton) {
        selectedAnswer = sender.currentTitle
    }
}
