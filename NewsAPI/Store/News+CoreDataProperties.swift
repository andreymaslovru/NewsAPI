//
//  News+CoreDataProperties.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 16.10.2021.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var url: String?

}

extension News : Identifiable {

}
