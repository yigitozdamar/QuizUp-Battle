//
//  RankingsViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import SETabView

class RankingsViewController: UIViewController, SETabItemProvider {
    
    var seTabBarItem: UITabBarItem? {
            return UITabBarItem(title: "", image: UIImage(systemName: "chart.bar"), tag: 0)
        }
    
    @IBOutlet weak var tableView: UITableView!
    var rankings: [Rankings] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults().object(forKey: "name"))
        
    }
    
    @IBAction func timeSegment(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            case 0:
                print("weekly")
            case 1:
                print("Alltime")
            default:
                break
        }
    }
   
    let users = [
        Rankings(name: "Mike", totalScore: 100),
        Rankings(name: "John", totalScore: 90),
        Rankings(name: "Yigit", totalScore: 80),
        Rankings(name: "Fernando", totalScore: 70),
    ]
    
}

extension RankingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rankingsCell", for: indexPath) as? RankingsTableViewCell else { return RankingsTableViewCell()}
        cell.listNumber.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = users[indexPath.row].name
        cell.totalScoreLabel.text = "\(users[indexPath.row].totalScore)"
        return cell
    }
    
    
}
