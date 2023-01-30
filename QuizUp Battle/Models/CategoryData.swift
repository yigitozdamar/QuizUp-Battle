//
//  CategoryData.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 28.01.2023.
//

import Foundation

struct CateogoryData: Decodable {
    var trivia_categories: [Category]
}

struct Category: Decodable {
    
    let id: Int
    let name: String
    var totalQuestion: Int
    
}


struct CategoryStats: Decodable {
    let category_id: Int
    var category_question_count: category_question_count
}
struct category_question_count: Decodable {
    let total_question_count: Int
    let total_easy_question_count: Int
    let total_medium_question_count: Int
    let total_hard_question_count: Int
}
