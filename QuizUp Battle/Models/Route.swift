//
//  Route.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 28.01.2023.
//

import Foundation

enum Route {
    static let baseUrl = "https://opentdb.com/api.php?"
    static let categoryUrl = "https://opentdb.com/api_category.php"
    
    case allQuestions
    case allCategories
    
    var description: String {
        switch self {
            case .allQuestions:
                return "https://opentdb.com/api.php?amount=50"
            case .allCategories:
                return "https://opentdb.com/api_category.php"
        }
    }
}
