//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 03.02.25.
//

import UIKit
import SDWebImage

class MovieDetailController: UIViewController {
    
    let viewModel = MovieDetailViewModel()
    
    private lazy var backImage: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var posterImage: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.layer.cornerRadius = 16
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textColor = .black
        l.textAlignment = .left
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [backImage,
         posterImage,
         titleLabel].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            backImage.heightAnchor.constraint(equalToConstant: 210),
            backImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            posterImage.widthAnchor.constraint(equalToConstant: 120),
            posterImage.heightAnchor.constraint(equalToConstant: 150),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            
            titleLabel.topAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
    }
    
    private func setupData() {
        backImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(self.viewModel.data?.backdropPath ?? "")")) { image, error, _, _ in
            if let image {
                self.backImage.image = image
            } else if let error {
                print(error)
            }
        }
        posterImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(self.viewModel.data?.posterPath ?? "")")) { image, error, _, _ in
            if let image {
                self.posterImage.image = image
            } else if let error {
                print(error)
            }
        }
        titleLabel.text = viewModel.data?.title
    }
    
    func configureData(data: MovieResult) {
        self.viewModel.data = data
    }
}
