//
//  SearchController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.02.25.
//

import UIKit

class SearchController: UIViewController {
    
//    MARK: Properties
    
    private let viewModel = SearchViewModel()
    private var items = ["Movies", "Actors", "Collections"]
    
//    MARK:  - UI elements
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: self.items)
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
        txt.placeholder = "Search for ..."
        txt.tintColor = .black
        let rightIcon = UIImageView(frame: CGRect(x: 10, y: 12.5, width: 24, height: 24))
        rightIcon.tintColor = .black
        rightIcon.image = UIImage(systemName: "magnifyingglass")
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightView.addSubview(rightIcon)
        txt.rightViewMode = .always
        txt.rightView = rightView
        txt.returnKeyType = .search
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.borderWidth = 1.5
        txt.addTarget(self, action: #selector(searchTextDidChange), for: .editingChanged)
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.dataSource = self
        t.delegate = self
        t.register(MovieCell.self, forCellReuseIdentifier: "\(MovieCell.self)")
        t.register(ImageLabelOvrCell.self, forCellReuseIdentifier: "\(ImageLabelOvrCell.self)")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        [segmentControl,
         searchView,
         table].forEach { view.addSubview($0) }
        table.refreshControl = refreshControl
        searchView.addSubview(searchField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 16),
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
        viewModel.success = { [weak self] in
            self?.table.reloadData()
            self?.table.refreshControl?.endRefreshing()
        }
        viewModel.errorHandler = { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
            self?.table.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func searchTextDidChange() {
        segmentChanged()
    }
    
    @objc private func segmentChanged() {
        guard let text = searchField.text else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewModel.fetchMovies(query: text)
            table.reloadData()
        case 1:
            viewModel.fetchActors(query: text)
            table.reloadData()
        case 2:
            viewModel.fetchCollections(query: text)
            table.reloadData()
        default:
            return
        }
    }
    
    @objc private func refreshData() {
        self.searchTextDidChange()
    }
}

//MARK: - Setup table

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return viewModel.searchedMovies.count
        case 1:
            return viewModel.searchedActors.count
        case 2:
            return viewModel.searchedCollections.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
            cell.configure(model: viewModel.searchedMovies[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageLabelOvrCell.self)") as! ImageLabelOvrCell
            cell.configure(model: viewModel.searchedActors[indexPath.row], collectionHidden: false)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageLabelOvrCell.self)") as! ImageLabelOvrCell
            cell.configure(model: viewModel.searchedCollections[indexPath.row], collectionHidden: true)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let vc = MovieDetailController()
            vc.viewModel.movieId = viewModel.searchedMovies[indexPath.row].id
            navigationController?.show(vc, sender: nil)
        case 1:
            let vc = ActorDetailController()
            vc.viewModel.actorId = viewModel.searchedActors[indexPath.row].id
            navigationController?.show(vc, sender: nil)
        case 2:
            let vc = CollectionController()
            vc.viewModel.collectionID = viewModel.searchedCollections[indexPath.row].id
            navigationController?.show(vc, sender: nil)
        default:
            return
        }
    }
}
