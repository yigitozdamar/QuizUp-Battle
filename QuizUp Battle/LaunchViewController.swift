//
//  LaunchViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 30.01.2023.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {
    private var animationView: LottieAnimationView!
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        categoryManager.fetchCategories { result in
            DispatchQueue.main.async{
              
                    self.categoryList = result.sorted { $0.name < $1.name }
              
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
                    vc.categoryList = self.categoryList
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                self.animationView.play { (finished) in
                    self.animationView!.isHidden = true
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
