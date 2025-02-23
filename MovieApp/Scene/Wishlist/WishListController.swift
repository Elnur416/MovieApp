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
        view.addSubview(table)
        table.frame = view.bounds
    }
    
    private func configureViewModel() {
        viewModel.success = { [weak self] in
            self?.table.reloadData()
        }
        viewModel.errorHandler = { [weak self] error in
            self?.showAlert(message: error)
        }
        viewModel.getMovies()
    }
}

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
}
