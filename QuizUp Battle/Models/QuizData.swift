//
//  QuizData.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 28.01.2023.
//

import Foundation

// MARK: - QuestionSelect

struct QuizData: Decodable {
    var response_code: Int
    var results: [QuestionData]
}

struct QuestionData: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    
    func shuffleAnswers() -> [String] {
        var allAnswers = incorrect_answers
        allAnswers.append(correct_answer)
        return allAnswers.shuffled()
    }
}


