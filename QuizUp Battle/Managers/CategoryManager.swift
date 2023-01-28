//
//  CategoryManager.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 28.01.2023.
//

import Foundation

struct CategoryManager {
    
    static let shared = CategoryManager()
    let baseURL = "https://opentdb.com"
    
    init() { }
    
    func fetchCategories(completion: @escaping ([Category]?) -> Void) {
        let url = URL(string: "https://opentdb.com/api_category.php")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let categoryData = try JSONDecoder().decode(CateogoryData.self, from: data)
                completion(categoryData.trivia_categories)
            } catch let error {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchCategoryTotalQuestion(id: Int,completion: @escaping (Category_question_count?) -> Void) {
        
        let url = URL(string: "\(baseURL)/api_count.php?category=\(id)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let totalQuestions = try JSONDecoder().decode(CategoryStats.self, from: data)
                completion(totalQuestions.category_question_count)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
        
        
    }
    
    
}
