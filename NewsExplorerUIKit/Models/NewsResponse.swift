//
//  NewsResponse.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    var title: String
    var description: String
    var urlToImage: String?
    var publishedAt: String
    var content: String
}
