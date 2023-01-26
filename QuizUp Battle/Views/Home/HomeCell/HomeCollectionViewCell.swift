//
//  HomeCollectionViewCell.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: HomeCollectionViewCell.self)

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
}
