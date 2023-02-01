//
//  Url+Extension.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 1.02.2023.
//

import Foundation
extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
