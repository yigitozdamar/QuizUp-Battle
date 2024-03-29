//
//  SettingsViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 30.01.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var questionTypeControl: UISegmentedControl!
    
    @IBOutlet weak var difficultyControl: UISegmentedControl!
    
    @IBOutlet weak var questionNumberPicker: UIPickerView!
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    var selectedTitle: String?
    private var selectedDifficulty = Difficulty.easy.rawValue
    private var selectedQuestionType = QuestionType.trueFalse.rawValue
    private var selectedQuestionNumber = 10
    var selectedCategory = ""
    private var pickerArray = Array(10...50)
    var questions = [QuestionData]()
    var shuffledAnswers = [String]()
    
    var settingsManager = SettingsManager()
    
    enum QuestionType: String {
        case trueFalse = "boolean"
        case multiple = "multiple"
        case all = ""
    }
    
    enum Difficulty: String {
        case easy = "easy"
        case medium = "medium"
        case hard = "hard"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTitleLabel?.text = selectedTitle
        UserDefaults().set(Auth.auth().currentUser?.displayName, forKey: "name")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameVC" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.modalTransitionStyle = .flipHorizontal
            destinationVC.questions = questions
            destinationVC.difficulty = selectedDifficulty
        }
    }
    
    @IBAction func questionTypeChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
                selectedQuestionType = QuestionType.trueFalse.rawValue
            case 1:
                selectedQuestionType = QuestionType.multiple.rawValue
            case 2:
                selectedQuestionType = QuestionType.all.rawValue
            default:
                break
        }
    }
    
    @IBAction func difficultyChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
                selectedDifficulty = Difficulty.easy.rawValue
            case 1:
                selectedDifficulty = Difficulty.medium.rawValue
            case 2:
                selectedDifficulty = Difficulty.hard.rawValue
            default:
                break
        }
    }
    //TODO: back button will be fixed
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLaunchVCfromSettings", sender: self)
    }
    
    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        
        settingsManager.createUrl(amount: String(selectedQuestionNumber), difficulty: selectedDifficulty, type: selectedQuestionType, category: selectedCategory)
        settingsManager.request { [weak self] result in
            guard let self = self else { return }
            
            self.questions = result
            
            for question in self.questions {
                self.shuffledAnswers = question.shuffleAnswers()
            }
            if result.isEmpty {
                let alert = UIAlertController(title: "Oppps",
                                              message: "Unfortunately we have not enough questions in your selection.",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
            }else {
                self.performSegue(withIdentifier: "toGameVC", sender: self)

            }
        }
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerArray[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedQuestionNumber = pickerArray[row]
    }
}
