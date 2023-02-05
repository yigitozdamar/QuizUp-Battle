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

    var questions: [QuestionData] = []
    
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
        print("GAME:.....")
        print(questions)
      collectionView.reloadData()
    }
    
//    func checkQuestion(correctAnswer: String) {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameDetail", for: indexPath) as? GameCollectionViewCell else {return GameCollectionViewCell()}
//        index += 1
//        collectionView.scrollToItem(at: index, at: .right, animated: true)
//    }
    
}

    
extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameDetail", for: indexPath) as? GameCollectionViewCell else {return GameCollectionViewCell()}
        cell.questionAmount.text = "QUESTION 3 OF 10"
        cell.questionLbl.text = questions[indexPath.row].question
        cell.firstBtn.setTitle(questions[indexPath.row].correct_answer, for: .normal)
        cell.secondBtn.setTitle(questions[indexPath.row].incorrect_answers[0], for: .normal)
        cell.thirdBtn.setTitle(questions[indexPath.row].incorrect_answers[1], for: .normal)
        cell.fourthBtn.setTitle(questions[indexPath.row].incorrect_answers[2], for: .normal)
        
        
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
