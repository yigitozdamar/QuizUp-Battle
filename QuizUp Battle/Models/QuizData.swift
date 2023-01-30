//
//  QuizData.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 28.01.2023.
//

import Foundation

// MARK: - QuestionSelect
struct QuestionSelect {
    let responseCode: Int
    let results: [Result]
}

// MARK: - Result
struct Result {
    let category: String
    let type: TypeEnum
    let difficulty: Difficulty
    let question, correctAnswer: String
    let incorrectAnswers: [String]
}

enum Difficulty {
    case easy
    case hard
    case medium
}

enum TypeEnum {
    case boolean
    case multiple
}


//
//struct QuizData: Decodable {
//    var results: [QuestionData]
//}
//
//struct QuestionData: Decodable {
//    let category: String
//    let type: String
//    let difficulty: String
//    let question: String
//    let correct_answer: String
//    let incorrect_answers: [String]
//}
