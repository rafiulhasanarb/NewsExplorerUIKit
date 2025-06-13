//
//  NewsViewModel.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Foundation

final class NewsViewModel {
    
    private let repository: NewsRepositoryProtocol
    var articles: [Article] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }
    
    func fetchArticles() {
        repository.getArticles { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.onUpdate?()
                case .failure(let error):
                    self?.onError?(error)
                }
            }
        }
    }
}
