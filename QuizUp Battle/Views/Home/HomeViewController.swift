//
//  HomeViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase
import SETabView
import FirebaseCore
import FirebaseFirestore
import FirebaseAnalytics

class HomeViewController: UIViewController, SETabItemProvider {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    var selectedTitle = ""
    var selectedCategory = ""
    var userID = ""
    let databaseRef = Database.database(url: "https://quizup-battle-default-rtdb.europe-west1.firebasedatabase.app").reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        score()
        collectionView.register(UINib(nibName: HomeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
   
        collectionView.reloadData()
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(String(describing: title))"
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    var seTabBarItem: UITabBarItem? {
            return UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "toSettingsVC" {
            if let destinationVC = segue.destination as? SettingsViewController {
                destinationVC.selectedTitle = selectedTitle
                destinationVC.selectedCategory = selectedCategory
                
            }
        }
    }
    
    func score() {
        
        if Auth.auth().currentUser?.uid != nil {
            self.userID = Auth.auth().currentUser?.uid ?? ""
        } else {
            self.userID = GIDSignIn.sharedInstance.currentUser?.userID ?? ""
        }
        
        let userRef = databaseRef.child("Users").child(self.userID)
        userRef.observeSingleEvent(of: .value) { snapshot, _  in
            if snapshot.exists() {
                if let userData = snapshot.value as? [String: Any], let name = userData["User"] as? String{
                    
                    UserDefaults.standard.set(name, forKey: "name")
                }
            } else {
                print("hata var")
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.setup(categoryList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let selectedItem = categoryList[indexPath.item]
        self.selectedTitle = selectedItem.name
        self.selectedCategory = selectedItem.id.description
        
        performSegue(withIdentifier: "toSettingsVC", sender: self)
        
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2 - 42, height: view.frame.size.width/2 - 42)
    }
}

