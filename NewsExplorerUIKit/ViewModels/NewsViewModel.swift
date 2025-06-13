//
//  NewsViewModel.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Combine
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

//MARK: - Using Combine framwork
class CombineNewsListViewModel {
    @Published var articles: [Article] = []
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: CombineNewsRepositoryProtocol
    
    init(repository: CombineNewsRepositoryProtocol = CombineNewsRepository()) {
        self.repository = repository
    }
    
    func fetchArticles() {
        repository.getArticles()
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    self.error = err.localizedDescription
                }
            }, receiveValue: { articles in
                self.articles = articles
            })
            .store(in: &cancellables)
    }
}
