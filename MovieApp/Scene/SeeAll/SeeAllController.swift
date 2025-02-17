//
//  SeeAllController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import UIKit

class SeeAllController: UIViewController {
    
    let viewModel = SeeAllViewModel()
    
//    MARK: Setup UI elements
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 80
        layout.sectionInset = .init(top: 24, left: 20, bottom: 40, right: 20)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(ImageLabelCell.self, forCellWithReuseIdentifier: "\(ImageLabelCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collection)
        collection.frame = view.bounds
        collection.refreshControl = refreshControl
        title = viewModel.selectedTitle
    }
    
    private func configureViewModel() {
        viewModel.completion = { [weak self] in
            self?.collection.reloadData()
            self?.collection.refreshControl?.endRefreshing()
        }
        viewModel.errorHandler = { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
            self?.collection.refreshControl?.endRefreshing()
        }
        viewModel.getMovies()
    }
    
    @objc private func refreshData() {
        self.viewModel.reset()
        self.viewModel.getMovies()
    }
}

//MARK: - Setup collection

extension SeeAllController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
        let model = viewModel.movieItems[indexPath.row]
        cell.configure(data: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailController()
        vc.viewModel.movieId = viewModel.movieItems[indexPath.row].id
        navigationController?.show(vc, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}
