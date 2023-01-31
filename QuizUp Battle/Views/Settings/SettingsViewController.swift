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
    private var difficultySelected = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTitleLabel.text = selectedTitle
        print(difficultySelected)
    }
    
  
    @IBAction func difficultyChanged(_ sender: AnyObject) {
        
        switch difficultyControl.selectedSegmentIndex {
            case 0:
                difficultySelected = "easy"
            case 1:
                difficultySelected = "medium"
            case 2:
                difficultySelected = "hard"
                
                print(difficultySelected)
            default:
                break
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func startGameButtonTapped(_ sender: UIButton) {
    }
    
    
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(10+row)"
    }
    
    
}
