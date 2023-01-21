//
//  UIView+Extension.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 20.01.2023.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    
}


