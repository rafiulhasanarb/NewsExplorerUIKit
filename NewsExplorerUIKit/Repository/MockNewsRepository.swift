//
//  MockNewsRepository.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Foundation

//MARK: MockNewsRepository for test
class MockNewsRepository: NewsRepositoryProtocol {
    
    private let apiService: NewsServiceProtocol
    
    init(apiService: NewsServiceProtocol = NewsService()) {
        self.apiService = apiService
    }
    
    func getArticles(completion: @escaping (Result<[Article], any Error>) -> Void) {
        apiService.fetchArticles { result in
            switch result {
            case .success(let articles):
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
