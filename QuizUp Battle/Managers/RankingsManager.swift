//
//  RankingsManager.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 15.02.2023.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

struct RankingsManager {
    static let shared = RankingsManager()
    var ref: DatabaseReference!
  
}
