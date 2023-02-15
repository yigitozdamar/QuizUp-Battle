//
//  RankingsManager.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 15.02.2023.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

struct RankingsManager {
    static let shared = RankingsManager()
    
    var databaseRef = Database.database().reference()
    var rankings: [Rankings] = []

}
