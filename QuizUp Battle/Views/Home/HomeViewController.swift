//
//  HomeViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import SETabView

class HomeViewController: UIViewController, SETabItemProvider {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    var selectedTitle = ""
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RankingsManager.shared.score { _, _ in
            return
        }
        collectionView.register(UINib(nibName: HomeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
   
        collectionView.reloadData()
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

