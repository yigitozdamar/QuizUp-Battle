//
//  TabbarViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 21.01.2023.
//

import UIKit
import SETabView

class TabbarViewController:  SETabViewController {
 
    var categoryList: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // set tab bar look collectively
        
        setTabColors(backgroundColor: UIColor(red: 239/255, green: 238/255, blue: 252/255, alpha: 1.0), ballColor: UIColor.purple.withAlphaComponent(0.7), tintColor: UIColor.white, unselectedItemTintColor: UIColor.black, barTintColor: .clear)
        
        // set the view controllers
        setViewControllers(getViewControllers())
        if let homeViewController = viewControllers.first as? HomeViewController {
           homeViewController.categoryList = categoryList
        }
    }
    private func getViewControllers() -> [UIViewController] {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return [
            storyboard.instantiateViewController(withIdentifier: "homeVC"),
            storyboard.instantiateViewController(withIdentifier: "rankingsVC"),
            storyboard.instantiateViewController(withIdentifier: "profileVC"),
            storyboard.instantiateViewController(withIdentifier: "DeleteVC"),
            
        ]
    }

}
