//
//  SeeAllController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import UIKit

class SeeAllController: UIViewController {
    
    let viewModel = SeeAllViewModel()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        layout.sectionInset = .init(top: 24, left: 20, bottom: 40, right: 20)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(MovieCell.self, forCellWithReuseIdentifier: "\(MovieCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collection)
        collection.frame = view.bounds
        title = viewModel.selectedTitle
    }
    
    func configureData(data: [MovieResult]) {
        self.viewModel.selectedMovies = data
    }
}

extension SeeAllController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.selectedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCell.self)", for: indexPath) as! MovieCell
        let model = viewModel.selectedMovies[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 240)
    }
}
