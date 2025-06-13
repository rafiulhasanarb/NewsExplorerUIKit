//
//  ConfigurationManager.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import Foundation

enum Environment {
    case development
    case qa
    case production
}

final class ConfigurationManager {
    
    static let shared = ConfigurationManager()
    
    private init() { }
    
    var environment: Environment {
        #if DEBUG
        return .development
        #elseif QA
        return .qa
        #else
        return .production
        #endif
    }
    
    var baseURL: String {
        switch environment {
        case .development:
            return AppConstant.devUrlString
        case .qa:
            return AppConstant.qaUrlString
        case .production:
            return AppConstant.urlString
        }
    }
}
