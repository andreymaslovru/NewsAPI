//
//  ApiService.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 12.10.2021.
//

import Foundation

 
class ApiService {
    private var dataTask: URLSessionDataTask?
    
    func getNewsData(page: Int, completion: @escaping (Result<Articles, Error>) -> Void) {
        
        let url = URL(string: "https://newsapi.org/v2/everything?q=ios&from=2019-04-00&sortBy=publishedAt&apiKey=26eddb253e7840f988aec61f2ece2907&page=\(page)")
        
//        let url = URL(string:"https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=5baf838cc2b941e2990fe64b6fb3145c")
//
        guard url != nil else { return print("dkgjkegje")}
        //Create URL Session
        
        dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //Handle Error
            if let error = error {
                completion(.failure(error))
                print("Data task error: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                //Handle Empty response
                print("Empty Response")
                return
            }
            
            print("Response code: \(response.statusCode)")
            
            guard let data = data else {
                //Handle Empty Data
                print("Empty Data")
                return
            }
            
            
            do {
                //Parse the data
                let decoder = JSONDecoder()
                let JSONData = try decoder.decode(Articles.self, from: data)
            
                CoreData.sharedInstance.saveDataOf(articles: JSONData as? [Article] ?? [])
                
                DispatchQueue.main.async {
                    completion(.success(JSONData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask!.resume()
    }
}
