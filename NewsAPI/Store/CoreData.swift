//
//  CoreData.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 16.10.2021.
//

import Foundation
import CoreData
import UIKit

class CoreData {
    
    static let sharedInstance = CoreData()
    private init(){}
    
    private let continer: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleEntity")
    
    func saveDataOf(articles: [Article]) {
        
        self.continer?.performBackgroundTask{ [weak self] (context) in
            self?.deleteObjectsfromCoreData(context: context)
            self?.saveDataToCoreData(articles: articles, context: context)
        }
    }
    
    // MARK: - Delete Core Data objects before saving new data
    private func deleteObjectsfromCoreData(context: NSManagedObjectContext) {
        do {
            let objects = try context.fetch(fetchRequest)
            
            _ = objects.map({context.delete($0 as! NSManagedObject)})
            
            try context.save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }
    
    // MARK: - Save new data from the server to Core Data
    private func saveDataToCoreData(articles:[Article], context: NSManagedObjectContext) {
        context.perform {
            for article in articles {
                let articleEntity = ArticleEntity(context: context)
                articleEntity.title = article.title
                articleEntity.desc = article.description
                articleEntity.publishedAt = article.publishedAt
                articleEntity.urlToImage = article.urlToImage
                articleEntity.url = article.url
            }
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
