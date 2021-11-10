//
//  Article.swift
//  PopularNews
//
//  Created by Shrimp Hsieh on 2021/11/10.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}
