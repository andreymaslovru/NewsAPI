//
//  Model.swift
//  NewsAPI
//
//  Created by Андрей Маслов on 12.10.2021.
//

import Foundation

struct Articles: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source;
    let author: String?;
    let title: String;
    let description: String?;
    let url: String?;
    let urlToImage: String?;
    let publishedAt: String?;
    let content: String?;
}

struct Source: Decodable {
    //let id: Int?
    let name: String?
}
