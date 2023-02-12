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
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    var filterCat: [Category] = []
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
        
//        categoryManager.fetchCategories { result in
//            DispatchQueue.main.async{
//
//                self.categoryList = result
//
//                self.filterCat = self.categoryList.map { Category(id: $0.id, name: $0.name.replacingOccurrences(of: "Entertainment: ", with: ""), totalQuestion: $0.totalQuestion)
//
//                }
//            }
//        }
    }
    
    @IBAction func returnHomeTapped(_ sender: UIButton) {
//        if filterCat.isEmpty {
//            let activityIndicator = UIActivityIndicatorView(style: .large)
//                  activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//                  activityIndicator.center = view.center
//                  activityIndicator.startAnimating()
//              view.addSubview(activityIndicator)
//
//              categoryManager.fetchCategories { result in
//                  DispatchQueue.main.async{
//                      self.categoryList = result
//                      self.filterCat = self.categoryList.map { Category(id: $0.id, name: $0.name.replacingOccurrences(of: "Entertainment: ", with: ""), totalQuestion: $0.totalQuestion)
//                      }
//                      activityIndicator.stopAnimating()
//                      activityIndicator.removeFromSuperview()
//                      let tabbarViewController = TabbarViewController()
//                      tabbarViewController.categoryList = self.filterCat
//                      tabbarViewController.modalPresentationStyle = .fullScreen
//                      self.present(tabbarViewController, animated: true, completion: nil)
//                  }
//              }
//          } else {
//              let tabbarViewController = TabbarViewController()
//              tabbarViewController.categoryList = filterCat
//              tabbarViewController.modalPresentationStyle = .fullScreen
//              self.present(tabbarViewController, animated: true, completion: nil)
//          }
        
        let launchScreen = LaunchViewController()
        launchScreen.modalPresentationStyle = .fullScreen
        self.present(launchScreen, animated: true, completion: nil)
      }
    
    @IBAction func restartGameTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSettingsVC", sender: self)
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





