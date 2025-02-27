//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 03.02.25.
//

import UIKit

class MovieDetailController: UIViewController {
    
    let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Setup UI elements
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 24, bottom: 24, right: 24)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(ImageLabelCell.self, forCellWithReuseIdentifier: "\(ImageLabelCell.self)")
        c.register(MovieHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(MovieHeaderView.self)")
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
        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(collection)
        collection.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(addWishlist))
    }
    
    private func configureViewModel() {
        viewModel.getMovieDetail()
        viewModel.getSimilarMovies()
        viewModel.getVideos()
        viewModel.success = { [weak self] in
            self?.collection.reloadData()
        }
        viewModel.errorHandler = { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
        }
    }
    
    @objc private func addWishlist() {
        guard let button = navigationItem.rightBarButtonItem else { return }
        
        let isFilled = button.image == UIImage(systemName: "bookmark.fill")
        button.image = UIImage(systemName: isFilled ? "bookmark" : "bookmark.fill")
        
        guard let movie = viewModel.data, !isFilled else { return }
        
        FirestoreManager.shared.saveMovie(model: movie) { error in
            if let error {
                self.showAlert(message: error)
            }
        }
    }
}

//MARK: - Setup collection

extension MovieDetailController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.segmentIndex == 0 {
            return viewModel.similarMovies.count
        } else {
            if viewModel.data?.belongsToCollection != nil {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
        if viewModel.segmentIndex == 0 {
            cell.configure(data: viewModel.similarMovies[indexPath.row])
        } else {
            if let data = viewModel.collection {
                cell.configure(data: data)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(MovieHeaderView.self)", for: indexPath) as! MovieHeaderView
        if let data = viewModel.data {
            header.configure(model: data)
        }
        header.segmentCallback = { [weak self] segmentIndex in
            self?.viewModel.segmentIndex = segmentIndex
            self?.collection.reloadData()
        }
        header.videoCallback = {
            let vc = TrailerController()
            guard let key = self.viewModel.video.filter({$0.type == "Trailer"}).first?.key
            else {
                let alert = UIAlertController(title: "Error", message: "Trailer not found...", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            vc.videoKey = key
            self.navigationController?.show(vc, sender: nil)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.segmentIndex == 0 {
            let vc = MovieDetailController(viewModel: .init(movieId: viewModel.movieId ?? 0))
            navigationController?.show(vc, sender: nil)
        } else {
            let vc = CollectionController(viewModel: .init(useCase: CollectionManager(), collectionID: viewModel.data?.belongsToCollection?.id ?? 0))
            navigationController?.show(vc, sender: nil)
        }
    }
}
