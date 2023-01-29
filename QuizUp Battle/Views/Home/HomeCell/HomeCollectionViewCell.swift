//
//  HomeCollectionViewCell.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: HomeCollectionViewCell.self)
    
    static let shared = HomeCollectionViewCell()

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    func setup(_ category : Category ) {
   
        headerLabel.text = category.name
        questionLabel.text = "\(category.totalQuestion) Questions"
    }
    
}
