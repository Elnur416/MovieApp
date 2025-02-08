//
//  SearchController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.02.25.
//

import UIKit

class SearchController: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "starColour")
        view.layer.cornerRadius = 27
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchField: UITextField = {
        let txt = UITextField()
        txt.layer.cornerRadius = 22
        txt.backgroundColor = .white
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        txt.leftViewMode = .always
        txt.placeholder = "Search for a movie"
        txt.tintColor = .black
        let rightIcon = UIImageView(frame: CGRect(x: 10, y: 12.5, width: 24, height: 24))
        rightIcon.tintColor = .black
        rightIcon.image = UIImage(systemName: "magnifyingglass")
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightView.addSubview(rightIcon)
        txt.rightViewMode = .always
        txt.rightView = rightView
        txt.returnKeyType = .search
        txt.layer.borderColor = UIColor.orange.cgColor
        txt.layer.borderWidth = 1.5
        txt.addTarget(self, action: #selector(searchTextDidChange), for: .editingChanged)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.dataSource = self
        t.delegate = self
        t.register(TableCell.self, forCellReuseIdentifier: "\(TableCell.self)")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        [searchView,
         table].forEach { view.addSubview($0) }
        searchView.addSubview(searchField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            searchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            searchView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.061),
            searchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchField.widthAnchor.constraint(equalTo: searchView.widthAnchor, multiplier: 0.97),
            searchField.heightAnchor.constraint(equalTo: searchView.heightAnchor, multiplier: 0.84),
            searchField.centerXAnchor.constraint(equalTo: searchView.centerXAnchor),
            searchField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            
            table.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 24),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureViewModel() {
        viewModel.getGenres()
        viewModel.success = {
            self.table.reloadData()
        }
        viewModel.errorHandler = { error in
            print(error)
        }
    }
    
    @objc private func searchTextDidChange() {
        guard let text = searchField.text else { return }
        viewModel.fetchMovies(query: text)
        table.reloadData()
    }
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TableCell.self)", for: indexPath) as! TableCell
        cell.configure(model: viewModel.searchedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
