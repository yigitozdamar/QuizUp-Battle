//
//  LaunchViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 30.01.2023.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController{
    
    @IBOutlet weak var animationView: LottieAnimationView!
 
    private let categoryManager = CategoryManager()
    private var categoryList: [Category] = []
    private var filteredCategories: [Category] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cachedCategories = UserDefaults.standard.data(forKey: "filteredCategories")

        if let cachedCategories = cachedCategories {
            self.filteredCategories = try! JSONDecoder().decode([Category].self, from: cachedCategories)
            
                    }
        
        if !filteredCategories.isEmpty{
            animationView?.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let tabbarVC = TabbarViewController()
                tabbarVC.categoryList = self.filteredCategories
                tabbarVC.modalPresentationStyle = .fullScreen
                self.present(tabbarVC, animated: true, completion: nil)
            }
        }else{
            self.animationView.play()
            self.animationView.loopMode = .loop
            categoryManager.fetchCategories {[weak self] result in
                guard let self = self else {return}
                DispatchQueue.main.async{
                    
                    self.categoryList = result
                    self.filteredCategories = self.categoryList.map { Category(id: $0.id, name: $0.name.replacingOccurrences(of: "Entertainment: ", with: ""), totalQuestion: $0.totalQuestion)
                    }
                    let encodedCategories = try? JSONEncoder().encode(self.filteredCategories)
                    UserDefaults.standard.set(encodedCategories, forKey: "filteredCategories")
                    
                    let tabbarViewController = TabbarViewController()
                    tabbarViewController.categoryList = self.filteredCategories
                    tabbarViewController.modalPresentationStyle = .fullScreen
                    self.present(tabbarViewController, animated: true, completion: nil)
                    
                    self.animationView.stop()
                }
            }
        }
    }
    
}
