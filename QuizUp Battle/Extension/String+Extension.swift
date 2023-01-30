//
//  String+Extension.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 30.01.2023.
//

import Foundation

extension String {
    /// Converts HTML string to a `NSAttributedString`
    
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
