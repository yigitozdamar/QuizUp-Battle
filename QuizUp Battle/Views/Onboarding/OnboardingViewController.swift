//
//  ViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 20.01.2023.
//

import UIKit
import FirebaseAuth

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [OnboardingSlide(image: UIImage(named: "illustration")),
                  OnboardingSlide(image: UIImage(named: "illustration1"))]
        Auth.auth().addStateDidChangeListener { auth, user in
                if user != nil{
                    // User is signed in.
                    print("User is not logged out.")
                    self.performSegue(withIdentifier: "launchSC", sender: nil)
                } else {
                    // No user is signed in.
                    print("No user is signed in.")
                }
            }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "signUp", sender: nil)
        
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
    
}
