//
//  RankingsTableViewCell.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 15.02.2023.
//

import UIKit

class RankingsTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listNumber: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var crownImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        genderImage.layer.cornerRadius = 0.5 * genderImage.bounds.size.width
        genderImage.clipsToBounds = true
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
