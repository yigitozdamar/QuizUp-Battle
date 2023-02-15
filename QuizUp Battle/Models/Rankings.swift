//
//  Rankings.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 15.02.2023.
//

import Foundation

struct Rankings {
    
    var name: String
    var totalScore: Int
    
    init(name: String, totalScore: Int) {
        self.name = name
        self.totalScore = totalScore
    }
}
