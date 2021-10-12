//
//  ViewController.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var apiService = ApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.getNewsData { (result) in
            print(result)
        }
    }
}

