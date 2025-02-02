//
//  MovieCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    
    private lazy var movieTitle: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = .systemFont(ofSize: 16, weight: .regular)
        l.textAlignment = .left
        l.numberOfLines = 0
        l.text = "Movie Name"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var movieImage: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 16
        i.clipsToBounds = true
        i.backgroundColor = .systemGray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [movieTitle,
         movieImage].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 232),
            movieImage.widthAnchor.constraint(equalToConstant: 168),
            
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 4),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configure(model: MovieResult) {
        movieTitle.text = "\(model.title ?? "") (\(model.releaseDate?.prefix(4) ?? ""))"
        movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(model.posterPath ?? "")")) { image, error, _, _ in
            if let image {
                self.movieImage.image = image
            } else if let error {
                print(error)
            }
        }
    }
}
