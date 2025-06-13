//
//  NewsRepository.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

final class NewsRepository: NewsRepositoryProtocol {
    private let service: NewsServiceProtocol
    
    init(service: NewsServiceProtocol = NewsService()) {
        self.service = service
    }
    
    func getArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        service.fetchArticles(completion: completion)
    }
}
