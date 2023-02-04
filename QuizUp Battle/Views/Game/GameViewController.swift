//
//  GameViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 31.01.2023.
//

import UIKit
struct QuestionDummy{
    let quesion: String
    let correctAnswer: String
    let wrongAnswers: [String]
}

class GameViewController: UIViewController {
    
//    var difficulty: String!
//    var questionType: String!
//    var questionNumber: Int!
//
    var questions: [QuestionData] = []
    var questionsDummy = [
        QuestionDummy(quesion: "how many episode in him?", correctAnswer: "9", wrongAnswers: ["2","6","11"]),
        QuestionDummy(quesion: "In which part of your body would you find the cruciate ligament?", correctAnswer: "Knee", wrongAnswers: ["Head", "Brain", "Elbow"]),
        QuestionDummy(quesion: "How many films have Al Pacino and Robert De Niro appeared in together?", correctAnswer: "Four (The Godfather Part 2, Heat, Righteous Kill, The Irishman)", wrongAnswers: ["Three", "Five", "Six"])
        
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    let settingsManager = SettingsManager()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        settingsManager.request { result in
//            self.questions = result
//                print(self.questions)
//
//        }
      collectionView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        if index < (self.questionsDummy.count ) {
            index += 1
            collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .right, animated: true)
        }else{
            //move to result controller
        }
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionsDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameDetail", for: indexPath) as? GameCollectionViewCell else {return GameCollectionViewCell()}
        cell.questionAmount.text = "QUESTION 3 OF 10"
        cell.questionLbl.text = questionsDummy[indexPath.row].quesion
        cell.firstBtn.setTitle(questionsDummy[indexPath.row].correctAnswer, for: .normal)
        cell.secondBtn.setTitle(questionsDummy[indexPath.row].wrongAnswers[0], for: .normal)
        cell.thirdBtn.setTitle(questionsDummy[indexPath.row].wrongAnswers[1], for: .normal)
        cell.fourthBtn.setTitle(questionsDummy[indexPath.row].wrongAnswers[2], for: .normal)
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
