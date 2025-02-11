//
//  ActorController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import UIKit

class ActorController: UIViewController {
    
    private let viewModel = ActorViewModel()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 70
        layout.sectionInset = .init(top: 16, left: 24, bottom: 44, right: 16)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(ImageLabelCell.self, forCellWithReuseIdentifier: "\(ImageLabelCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collection)
        collection.frame = view.bounds
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Actors"
    }
    
    private func configureViewModel() {
        viewModel.fetchActors()
        viewModel.completion = {
            self.collection.reloadData()
        }
        viewModel.errorHandler = { error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

extension ActorController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
        cell.configure(data: viewModel.actors[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ActorDetailController()
        vc.viewModel.actorId = viewModel.actors[indexPath.row].id
        navigationController?.show(vc, sender: nil)
    }
}
