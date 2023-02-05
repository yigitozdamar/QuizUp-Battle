//
//  String+Extension.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 30.01.2023.
//

import Foundation

extension String {
    /// Converts HTML string to a `NSAttributedString`
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
