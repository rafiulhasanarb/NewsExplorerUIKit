//
//  NewsRepository.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Combine
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

//MARK: - Using Combine framwork
protocol CombineNewsRepositoryProtocol {
    func getArticles() -> AnyPublisher<[Article], Error>
}

class CombineNewsRepository: CombineNewsRepositoryProtocol {
    private let service: CombineNewsServiceProtocol

    init(service: CombineNewsServiceProtocol = CombineNewsAPIService()) {
        self.service = service
    }

    func getArticles() -> AnyPublisher<[Article], Error> {
        return service.fetchArticles()
    }
}
