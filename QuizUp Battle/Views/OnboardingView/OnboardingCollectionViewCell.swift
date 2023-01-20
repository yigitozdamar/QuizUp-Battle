//
//  OnboardingCollectionViewCell.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 20.01.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    
    
    func setup (_ slide: OnboardingSlide){
  
       slideImageView.image = slide.image
    }
}


