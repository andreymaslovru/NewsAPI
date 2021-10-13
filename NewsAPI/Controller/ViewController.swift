//
//  ViewController.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var apiService = ApiService()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.getNewsData { (result) in
            print(result)
        }
        
        loadData()
    }
    
    private func loadData() {
        viewModel.fetchNewsData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        
        let article = viewModel.cellForRowAt(indexPath: indexPath)
        cell.selCellWithValuesOf(article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
}


