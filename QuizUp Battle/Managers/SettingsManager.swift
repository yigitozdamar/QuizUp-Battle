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
        AF.request(urlRequest ?? "").responseData { response in
            print("Response Data:", response)
            if let data = response.data {
                do {
                    let quizData = try JSONDecoder().decode(QuizData.self, from: data)
                    print("Quiz Data:", quizData)
                    completion(quizData.results)
                    print("Completion handler executed")
                } catch {
                    print("Decoding error:", error)
                }
            }
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


