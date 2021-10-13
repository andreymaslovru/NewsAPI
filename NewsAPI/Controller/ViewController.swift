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
        self.tableView.delegate = self
        
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

extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            sheet.addAction(UIAlertAction(title: "Go to a web", style: .default, handler: { _ in
                print("go to the website")
            }))
            self.present(sheet, animated: true)
        }
}



