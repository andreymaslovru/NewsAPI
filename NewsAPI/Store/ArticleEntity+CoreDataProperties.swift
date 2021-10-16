//
//  ArticleEntity+CoreDataProperties.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 16.10.2021.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var desc: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?

}

extension ArticleEntity : Identifiable {

}
