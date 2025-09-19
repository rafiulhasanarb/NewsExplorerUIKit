//
//  Coordinator.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 7/1/25.
//

import UIKit
import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class NewsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController = .init()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // let hmVM = CombineNewsListViewModel()
        let vc = ListViewController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    /*
    func showDetail(with data: String) {
        let child = DetailCoordinator(navigationController: navigationController, data: data)
        childCoordinators.append(child)
        child.start()
    }
    */
}
