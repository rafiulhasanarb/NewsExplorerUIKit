//
//  NewsService.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Combine
import Foundation

enum NetworkError: Error {
    case invalidURL
    case urlSessionFailed
    case noData
}

protocol NewsServiceProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

final class NewsService: NewsServiceProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: AppConstant.urlString ) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(.success(response.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

//MARK: - using Combine framework
protocol CombineNewsServiceProtocol {
    func fetchArticles() -> AnyPublisher<[Article], Error>
}

class CombineNewsAPIService: CombineNewsServiceProtocol {
    func fetchArticles() -> AnyPublisher<[Article], Error> {
        let url = URL(string: AppConstant.urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map(\.articles)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
