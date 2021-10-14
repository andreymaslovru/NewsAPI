//
//  ViewController.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var page = 1;
    
    var apiService = ApiService()
    var isConnectedNetwork = Reachability()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorLoadingProcess: UIActivityIndicatorView!
    
    @IBOutlet weak var refetchBtn: UIButton!
    @IBAction func refetchRequest(_ sender: Any) {
        loadData(page: page)
    }
    
    private var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorLoadingProcess.isHidden = false
        indicatorLoadingProcess.startAnimating()
        self.tableView.delegate = self
        
        guard Reachability.isConnectedToNetwork() else {
            self.refetchBtn.isHidden = false
            self.indicatorLoadingProcess.isHidden = true
            return
        }
        
        self.refetchBtn.isHidden = true
        
        apiService.getNewsData(page: page) { (result) in
            
            DispatchQueue.main.async {
                self.indicatorLoadingProcess.stopAnimating()
                self.indicatorLoadingProcess.isHidden = true
                self.tableView.reloadData()
            }
        }
        
        loadData(page: 1)
        //self.tableView.reloadData()
    }
    
    private func loadData(page: Int) {
        viewModel.fetchNewsData(page: page)
        self.tableView.dataSource = self
        self.tableView.reloadData()
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
        
        let article = viewModel.cellForRowAt(indexPath: indexPath)
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Go to a web", style: .default, handler: { _ in
            let st = UIStoryboard(name: "Main", bundle: nil)
            let vc = st.instantiateViewController(withIdentifier: "WebView") as! WebViewController
            vc.url = article.url!
            self.present(vc, animated: true)
        }))
        self.present(sheet, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y + 200 > scrollView.contentSize.height - scrollView.frame.size.height {
            page += 1
            viewModel.fetchNewsData(page: page)
            print(page)
            self.tableView.reloadData()
        }
    }
}




