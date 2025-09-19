//
//  CoordinatorBoard.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 7/1/25.
//

import Foundation
import UIKit

protocol CoordinatorBoard: UIViewController {
    static func instantiateFromStoryboard() -> Self
}

extension CoordinatorBoard {
    static func instantiateFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
