//
//  NewsViewModel.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 13.10.2021.
//

import Foundation
import UIKit

class NewsViewModel {
    private var apiService = ApiService()
    private var articles = [Article]()

    func fetchNewsData(page: Int) {
        apiService.getNewsData(page: page) { (result) in
            switch result {
            case .success(let listOf):
                self.articles.append(contentsOf: listOf.articles)
                //completion()
            case .failure(let error):
                print("Error fetch json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if articles.count != 0 {
            return articles.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
}
