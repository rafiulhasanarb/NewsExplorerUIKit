//
//  ListViewController.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    
    private let viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "News Explorer"
        setupTableView()
        bindViewModel()
        viewModel.fetchArticles()
    }

    private func setupTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.newsTableView.reloadData()
        }
        
        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.configureUI(with: viewModel.articles[indexPath.row])
        return cell
    }
}
