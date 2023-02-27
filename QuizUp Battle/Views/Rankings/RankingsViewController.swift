//
//  RankingsViewController.swift
//  QuizUp Battle
//
//  Created by Yigit Ozdamar on 26.01.2023.
//

import UIKit
import SETabView
import FirebaseDatabase
import FirebaseAuth

class RankingsViewController: UIViewController, SETabItemProvider {
  
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    var indexPath: IndexPath!
    var users: [Rankings] = []
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(systemName: "chart.bar"), tag: 0)
    }
    override func viewDidLoad() {
        fetchFromDbWeekly()
        tableView.reloadData()
    }
    
    @IBAction func timeSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            fetchFromDbWeekly()
        case 1:
            fetchFromDbAllTime()
        default:
            break
        }
    }
}
//MARK: - Tableview
extension RankingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rankingsCell", for: indexPath) as? RankingsTableViewCell else { return RankingsTableViewCell()}
        cell.listNumber.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = users[indexPath.row].name
        cell.totalScoreLabel.text = "\(users[indexPath.row].totalScore)"
        cell.crownImage.isHidden = false
        cell.crownImage.tintColor = nil
        if indexPath.row == 0{
            cell.crownImage.tintColor = .systemYellow
        }else if indexPath.row == 1{
            cell.crownImage.tintColor = .gray
        }else if indexPath.row == 2{
            cell.crownImage.tintColor = .brown
        }else{
            cell.crownImage.isHidden = true
        }
        if users[indexPath.row].gender == "female"{
            cell.genderImage.image = UIImage(named: "woman")
            cell.genderImage.backgroundColor = UIColor(red: 0.882, green: 0.765, blue: 0.863, alpha: 1.0)
        }else{
            cell.genderImage.image = UIImage(named: "man")
            cell.genderImage.backgroundColor = UIColor(red: 0.698, green: 0.804, blue: 0.882, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? RankingsTableViewCell else {
            return
        }
            if indexPath == self.indexPath {
                cell.view.backgroundColor = .red
            } else {
                cell.view.backgroundColor = .white
            
        }
    }
}

//MARK: - Firebase Data Fetch
extension RankingsViewController{
    
    func fetchFromDbAllTime() {
        ref = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference().child("Users")
        
        ref?.observe(.value, with: { [weak self] snapshot in
            self?.users.removeAll()
            for child in snapshot.children {
                if let data = child as? DataSnapshot, let dict = data.value as? [String: Any] {
                    if let user = dict["User"] as? String, let totalScore = dict["TotalScore"] as? Int, let gender = dict["gender"] as? String {
                      
                        let fetchedUser = Rankings(name: user, totalScore: totalScore, gender: gender)
                        self?.users.append(fetchedUser)
                    }
                }
                // Sort the users array by TotalScore in descending order
                self?.users.sort { $0.totalScore > $1.totalScore }
                self?.tableView.reloadData()
                
                if let index = self?.users.firstIndex(where: { $0.name == UserDefaults().object(forKey: "name") as? String }) {
                    // Scroll to the row corresponding to the newly added item
                    self?.indexPath = IndexPath(row: index, section: 0)
                    self?.tableView.scrollToRow(at: (self?.indexPath)!, at: .middle, animated: true)
                    
                } else {
                    print("6 is not in the array")
                }
            }
        })
    }
    
    func fetchFromDbWeekly() {
        ref = Database.database(url: "https://quizupbattle-default-rtdb.europe-west1.firebasedatabase.app").reference().child("Users")
        
        // Calculate the start and end timestamps for the past week
        let endTimestamp = Date().timeIntervalSince1970
        let startTimestamp = Calendar.current.date(byAdding: .day, value: -7, to: Date())?.timeIntervalSince1970 ?? 0
        
        // Create a query to fetch data from the past week
        let query = ref?.queryOrdered(byChild: "time").queryStarting(atValue: startTimestamp).queryEnding(atValue: endTimestamp)
        
        query?.observe(.value, with: { [weak self] snapshot in
            self?.users.removeAll()
            for child in snapshot.children {
                if let data = child as? DataSnapshot, let dict = data.value as? [String: Any] {
                    if let user = dict["User"] as? String, let totalScore = dict["TotalScore"] as? Int, let gender = dict["gender"] as? String  {
                   
                        let fetchedUser = Rankings(name: user, totalScore: totalScore, gender: gender)
                        
                        self?.users.append(fetchedUser)
                    }
                }
            }
            
            // Sort the users array by TotalScore in descending order
            self?.users.sort { $0.totalScore > $1.totalScore }
            self?.tableView.reloadData()
            
            if let index = self?.users.firstIndex(where: { $0.name == UserDefaults().object(forKey: "name") as? String }) {
                // Scroll to the row corresponding to the newly added item
                self?.indexPath = IndexPath(row: index, section: 0)
                self?.tableView.scrollToRow(at: (self?.indexPath)!, at: .middle, animated: true)
            }else {
                self?.indexPath = nil
            }
        })
    }
}
