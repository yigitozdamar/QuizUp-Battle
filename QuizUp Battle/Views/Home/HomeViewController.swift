//
//  HomeViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import SETabView

class HomeViewController: UIViewController, SETabItemProvider {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    let categoryManager = CategoryManager()
    var categoryList: [Category] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: HomeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        categoryManager.fetchCategories { result in
            DispatchQueue.main.async{
                self.activityIndicator.startAnimating()
                self.categoryList = result.sorted { $0.name < $1.name }
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    var seTabBarItem: UITabBarItem? {
            return UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
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
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2 - 42, height: view.frame.size.width/2 - 42)
    }
}

