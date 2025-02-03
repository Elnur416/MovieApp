//
//  HomeController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.02.25.
//

import UIKit

class HomeController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
//    MARK: setup UI elements
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.sectionInset = .init(top: 24, left: 0, bottom: 24, right: 0)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(HomeCell.self, forCellWithReuseIdentifier: "\(HomeCell.self)")
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
        view.addSubview(collection)
        collection.frame = view.bounds
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Movies"
    }
    
    private func configureViewModel() {
        viewModel.getAllData()
        viewModel.completion = {
            self.collection.reloadData()
        }
        viewModel.errorHandler = { error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
    }
}

//MARK: - Setup collection

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeCell.self)", for: indexPath) as! HomeCell
        let model = viewModel.movieItems[indexPath.row]
        cell.configure(text: model.title, data: model.items)
        cell.titleCallBack = { title in
            let vc = SeeAllController()
            vc.viewModel.selectedTitle = title
            if let data = self.viewModel.filterMovies(title: title).first {
                vc.configureData(data: data.items)
                self.navigationController?.show(vc, sender: nil)
            }
        }
        cell.indexCallBack = { index, title in
            let model = self.viewModel.filterMovies(title: title).first
            if let data = model?.items[index] {
                let vc = MovieDetailController()
                vc.configureData(data: data)
                self.navigationController?.show(vc, sender: nil)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 320)
    }
}
