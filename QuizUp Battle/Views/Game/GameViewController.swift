//
//  GameViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 31.01.2023.
//

import UIKit

class GameViewController: UIViewController, GameCollectionViewCellDelegate {
    
    var difficulty: String!
    var questionType: String!
    var questionNumber: Int!

    var questions: [QuestionData] = []
    var shuffledAnswersArray = [[String]]()
    let settingsManager = SettingsManager()
    var index = 0
    var count = 0
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GAME:.....")
        setUpQuestionsAndAnswers()

        collectionView.reloadData()
    }
    
    func setUpQuestionsAndAnswers() {
        for question in questions {
            let shuffledAnswers = question.shuffleAnswers()
            shuffledAnswersArray.append(shuffledAnswers)
        }
    }
    
    func answerSelected(for cell: GameCollectionViewCell, with result: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let nextIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
        
        
        if nextIndexPath.item < questions.count && result  {
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            count += 1
            
        }else if nextIndexPath.item < questions.count && !result{
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
           
        } else {
            print("Sayfa Bitti")
            performSegue(withIdentifier: "toResultGameVC", sender: self)
        }
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultGameVC" {
            let destinationVC = segue.destination as! ResultGameViewController
            destinationVC.result = count
            destinationVC.questionDifficulty = difficulty
        }
    }
    
    func countdownFinished(for cell: GameCollectionViewCell) {
         guard let indexPath = collectionView.indexPath(for: cell) else { return }
         let nextIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
         
         if nextIndexPath.item < questions.count {
             collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            
         }else if nextIndexPath.item < questions.count {
             collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            
         } else {
             print("Sayfa Bitti")
             performSegue(withIdentifier: "endGame", sender: self)
         }
     }
    
}
    
extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameDetail", for: indexPath) as? GameCollectionViewCell else {return GameCollectionViewCell()}
        
        cell.delegate = self
        cell.questionAmount.text = "QUESTION \(indexPath.row + 1) OF \(questions.count)"
        cell.questionLbl.text = questions[indexPath.row].question
        cell.scoreLabel.text = "Score: \(count)"
        
        if questions[indexPath.row].type == "boolean" {
            cell.firstBtn.setTitle(shuffledAnswersArray[indexPath.row][0], for: .normal)
            cell.secondBtn.setTitle(shuffledAnswersArray[indexPath.row][1], for: .normal)
            cell.thirdBtn.isHidden = true
            cell.fourthBtn.isHidden = true
            cell.invalidateIntrinsicContentSize()
          
        } else {
            cell.firstBtn.setTitle(shuffledAnswersArray[indexPath.row][0], for: .normal)
            cell.secondBtn.setTitle(shuffledAnswersArray[indexPath.row][1], for: .normal)
            cell.thirdBtn.setTitle(shuffledAnswersArray[indexPath.row][2], for: .normal)
            cell.fourthBtn.setTitle(shuffledAnswersArray[indexPath.row][3], for: .normal)
        }
       
        cell.firstBtn.backgroundColor = UIColor.systemGray6
        cell.secondBtn.backgroundColor = UIColor.systemGray6
        cell.thirdBtn.backgroundColor = UIColor.systemGray6
        cell.fourthBtn.backgroundColor = UIColor.systemGray6
      
        cell.questions = questions[indexPath.row]
        cell.startCountdown(countFired: 10)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
