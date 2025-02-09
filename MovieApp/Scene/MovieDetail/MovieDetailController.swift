//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 03.02.25.
//

import UIKit

class MovieDetailController: UIViewController {
    
    let viewModel = MovieDetailViewModel()
    
//    MARK: Setup UI elements
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.allowsSelection = false
        t.dataSource = self
        t.delegate = self
        t.register(MovieDetailCell.self, forCellReuseIdentifier: "\(MovieDetailCell.self)")
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
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(table)
        table.frame = view.bounds
    }
    
    private func configureViewModel() {
        viewModel.getMovieDetail()
        viewModel.getSimilarMovies()
        viewModel.success = { [weak self] in
            self?.table.reloadData()
        }
        viewModel.errorHandler = { error in
            print(error)
        }
    }
}

extension MovieDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieDetailCell.self)", for: indexPath) as! MovieDetailCell
        guard let data = viewModel.data else { return cell }
        cell.configure(model: data, similar: viewModel.similarData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
