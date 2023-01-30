//
//  CategoryManager.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 28.01.2023.
//

import Foundation
import Alamofire
import SwiftyJSON


struct CategoryManager {
    
    static let shared = CategoryManager()
    let baseURL = "https://opentdb.com"
    let cache = NSCache<NSString, AnyObject>()
    
    init() { }
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        AF.request("https://opentdb.com/api_category.php").response { response in
            guard let data = response.data else { return }
            let json = JSON(data)
            var categories = [Category]()
            for category in json["trivia_categories"].arrayValue {
                let id = category["id"].intValue
                let name = category["name"].stringValue
                self.fetchQuestionCount(categoryId: id) { questionCount in
                    categories.append(Category(id: id, name: name, totalQuestion: questionCount))
                    if categories.count == json["trivia_categories"].arrayValue.count {
                        completion(categories)
                    }
                }
            }
        }
    }

    func fetchQuestionCount(categoryId: Int, completion: @escaping (Int) -> Void) {
        let url = "https://opentdb.com/api_count.php?category=\(categoryId)"
        AF.request(url).response{ response in
            guard let data = response.data else { return }
            let json = JSON(data)
            let questionCount = json["category_question_count"]["total_question_count"].intValue

            completion(questionCount)

        }
    }

    
    
}
