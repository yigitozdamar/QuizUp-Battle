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
    
//    func fetchQuestions(completion: @escaping ([QuestionSelect]) -> Void) {
//        AF.request("https://opentdb.com/api_category.php").response { response in
//            guard let data = response.data else { return }
//            let json = JSON(data)
//            var categories = [Category]()
//            for category in json["trivia_categories"].arrayValue {
//                let id = category["id"].intValue
//                let name = category["name"].stringValue
//                self.fetchQuestionCount(categoryId: id) { questionCount in
//                    categories.append(Category(id: id, name: name, totalQuestion: questionCount))
//                    if categories.count == json["trivia_categories"].arrayValue.count {
//                        completion(categories)
//                    }
//                }
//            }
//        }
//    }
}
