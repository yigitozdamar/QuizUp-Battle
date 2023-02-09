//
//  SettingsManager.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 31.01.2023.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SettingsManager {
    static let shared = SettingsManager()
    let base_URL = "https://opentdb.com/api.php?"
    var urlRequest: String?
    
    func request( completion: @escaping ([QuestionData]) -> Void){
        AF.request(urlRequest ?? "").response { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            var questions = [QuestionData]()
            for question in json["results"].arrayValue {
                let category = question["category"].stringValue
                let type = question["type"].stringValue
                let difficulty = question["difficulty"].stringValue
                let questionText = question["question"].stringValue.htmlToString
                let correctAnswer = question["correct_answer"].stringValue.htmlToString
                let incorrectAnswers = question["incorrect_answers"].arrayValue.map { $0.stringValue.htmlToString }
                questions.append(QuestionData(category: category, type: type, difficulty: difficulty, question: questionText, correct_answer: correctAnswer, incorrect_answers: incorrectAnswers))
            }
            completion(questions)
        }
    }

    mutating func createUrl(amount: String,
                            difficulty:String,
                            type: String,
                            category: String) -> String?{
        let urlString = "\(base_URL)amount=\(amount)&difficulty=\(difficulty)&type=\(type)&category=\(category)"
        urlRequest = urlString
        
        return urlRequest
    }
}


