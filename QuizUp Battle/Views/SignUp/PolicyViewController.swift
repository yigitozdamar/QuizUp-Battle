//
//  PolicyViewController.swift
//  QuizUp Battle
//
//  Created by Emre ÖZKÖK on 28.02.2023.
//

import UIKit
import WebKit

class PolicyViewController: UIViewController {

    @IBOutlet weak var webkite: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let policy = URL(string: "https://www.freeprivacypolicy.com/live/d8cccb5c-ddbb-4e55-8a44-6b55700ca103"){
            let request = URLRequest(url: policy)
            webkite.load(request)
        }

    }
    
    @IBAction func backtoSignUp(_ sender: Any) {
        dismiss(animated: true)
    }
}
