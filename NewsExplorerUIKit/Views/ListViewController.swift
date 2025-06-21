//
//  ListViewController.swift
//  NewsExplorerUIKit
//
//  Created by Rafiul Hasan on 6/13/25.
//

import UIKit
import Combine

class ListViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var searchByAuthorTF: UISearchBar!
    
    private let viewModel = NewsViewModel()
    //MARK: - Using Combine framwork
    private let combineViewModel = CombineNewsListViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "News Explorer"
        searchByAuthorTF.heightAnchor.constraint(equalToConstant: 44).isActive = true
        setupTableView()
        //MARK: - Using completion
        //bindViewModel()
        //viewModel.fetchArticles()
        
        //MARK: - Using Combine framwork
        CombineViewModel()
        combineViewModel.fetchArticles()
    }

    private func setupTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    //MARK: - Using completion
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
    
    //MARK: - Using Combine framwork
    private func CombineViewModel() {
        combineViewModel.$articles
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.newsTableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.articles.count
        //MARK: - Using Combine framwork
        return combineViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        //cell.configureUI(with: viewModel.articles[indexPath.row])
        //MARK: - Using Combine framwork
        cell.configureUI(with: combineViewModel.articles[indexPath.row])
        return cell
    }
}
