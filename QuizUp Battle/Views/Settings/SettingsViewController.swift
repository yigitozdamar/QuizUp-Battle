//
//  SettingsViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 30.01.2023.
//

import UIKit

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
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func startGameButtonTapped(_ sender: UIButton) {
        
        settingsManager.createUrl(amount: String(selectedQuestionNumber), difficulty: selectedDifficulty, type: selectedQuestionType, category: selectedCategory)
        settingsManager.request { result in
            print("result :   \(result)")
            self.questions = result
            print("SHUFFLE")
            for question in self.questions {
                self.shuffledAnswers = question.shuffleAnswers()
            }
            
            self.performSegue(withIdentifier: "toGameVC", sender: self)
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
