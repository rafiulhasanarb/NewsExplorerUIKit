//
//  MockNewsAPIService.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Foundation

//MARK: MockNewsService for test
final class MockNewsAPIService: NewsServiceProtocol {
    let article = Article(author: "rafiul", title: "Mock Title", description: "Mock Description", urlToImage: "nil", publishedAt: "nil", content: "content")
    
    func fetchArticles(completion: @escaping (Result<[Article], any Error>) -> Void) {
        completion(.success([article]))
    }
}
