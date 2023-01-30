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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
