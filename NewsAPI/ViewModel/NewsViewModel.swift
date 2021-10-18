//
//  NewsViewModel.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 13.10.2021.
//

import Foundation
import UIKit
import CoreData

protocol UpdateTableViewDelegate: NSObjectProtocol {
    func reloadData(sender: NewsViewModel)
}

class NewsViewModel: NSObject, NSFetchedResultsControllerDelegate {
    
    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private var fetchedResultController: NSFetchedResultsController<ArticleEntity>?
    
    weak var delegate: UpdateTableViewDelegate?
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Fetched Results Controller - Retrieve data from Core Data
    func retrieveDataFromCoreData() {
        
        if let context = self.container?.viewContext {
            let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
            
            // Sort movies by rating
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(ArticleEntity.publishedAt), ascending: false)]
            
            self.fetchedResultController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
            // Notifies the tableView when any changes have occurred to the data
            fetchedResultController?.delegate = self
            
            // Fetch data
            do {
                try self.fetchedResultController?.performFetch()
            } catch {
                print("Failed to initialize FetchedResultsController: \(error)")
            }
        }
    }
    
    private var apiService = ApiService()
    private var articles = [Article]()
    private var news = [ArticleEntity]()

    func fetchNewsData(page: Int) {
        apiService.getNewsData(page: page) { (result) in
            switch result {
            case .success(let listOf):
                //save data to Core Data
                CoreData.sharedInstance.saveDataOf(articles: listOf.articles)
                //self.articles.append(contentsOf: listOf.articles)
            case .failure(let error):
                //self.showAlertWith(title: "Error connected to network", message: "Error")
                print("Error fetch json data: \(error)")
            }
        }
    }
    
//    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
//        let action = UIAlertAction(title: "OK", style: .default) { (action) in
//            self.dismiss(animated: true, completion: nil)
//        }
//        alertController.addAction(action)
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.delegate?.reloadData(sender: self)
    }
    
    //MARK: - TableView DataSource functions
    func numberOfRowsInSection (section: Int) -> Int {
        return fetchedResultController?.sections?[section].numberOfObjects ?? 0
    }
    
    func object (indexPath: IndexPath) -> ArticleEntity? {
        return fetchedResultController?.object(at: indexPath)
    }
    
//    func numberOfRowsInSection(section: Int) -> Int {
//        if articles.count != 0 {
//            return articles.count
//        }
//        return 0
//    }
//
//    func cellForRowAt(indexPath: IndexPath) -> Article {
//        return articles[indexPath.row]
//    }
    
    //core data
    
    func getAllNews() {
        do {
            news = try self.container!.viewContext.fetch(ArticleEntity.fetchRequest())
        } catch let error {
            print("error fetch items from core data: \(error)")
        }
    }
    
    func addNewsInList(list: [Article]) {
        //news.append(contentsOf: list)
    }
}
