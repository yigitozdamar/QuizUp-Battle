//
//  LaunchViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 30.01.2023.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController{
    
    private var animationView: LottieAnimationView!
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    var filteredCategories: [Category] = []
    
    deinit {
        animationView = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        let cachedCategories = UserDefaults.standard.data(forKey: "filteredCategories")
        
        if let cachedCategories = cachedCategories {
            self.filteredCategories = try! JSONDecoder().decode([Category].self, from: cachedCategories)
            
        }
        if !filteredCategories.isEmpty{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let tabbarVC = TabbarViewController()
                tabbarVC.categoryList = self.filteredCategories
                tabbarVC.modalPresentationStyle = .fullScreen
                self.present(tabbarVC, animated: true, completion: nil)
            }
        }else{
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
                    
                    self.animationView.play { [weak self] (finished) in
                        self?.animationView!.isHidden = true
                        self?.animationView.stop()
                    }
                }
            }
        }
    }
    
    func setupAnimation(){
        animationView = .init(name: "116593-triviaw")
        animationView.frame = view.frame
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        animationView.play()
    }
}
