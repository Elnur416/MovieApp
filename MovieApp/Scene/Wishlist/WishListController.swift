//
//  FavouritesController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 22.02.25.
//

import UIKit

class WishListController: UIViewController {
    
    private let viewModel = WishlistViewModel()
    
//    MARK: UI elements
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.dataSource = self
        t.delegate = self
        t.register(MovieCell.self, forCellReuseIdentifier: "\(MovieCell.self)")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(table)
        table.refreshControl = refreshControl
        title = "Wishlist"
        table.frame = view.bounds
    }
    
    private func configureViewModel() {
        viewModel.success = { [weak self] in
            self?.table.reloadData()
            self?.table.refreshControl?.endRefreshing()
        }
        viewModel.errorHandler = { [weak self] error in
            self?.showAlert(message: error)
            self?.table.refreshControl?.endRefreshing()
        }
        viewModel.getData()
    }
    
    @objc private func refreshData() {
        self.viewModel.reset()
        self.viewModel.getData()
    }
    
    private func showMovieDetail(id: Int) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController ?? UINavigationController(),id: id)
        coordinator.start()
    }
}

//MARK: - Setup TableView

extension WishListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieCell.self)") as! MovieCell
        cell.configure(model: viewModel.movies[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FirestoreManager.shared.deleteDocument(movieID: viewModel.movies[indexPath.item].id ?? 0)
            viewModel.movies.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.movies[indexPath.item].id else { return }
        showMovieDetail(id: id)
    }
}
