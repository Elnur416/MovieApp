//
//  MovieCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import UIKit

class ImageLabelCell: UICollectionViewCell {
    
//    MARK: Setup UI elements
    
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
    
//    MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        [movieTitle,
         movieImage].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 240),
            movieImage.widthAnchor.constraint(equalToConstant: 168),
            
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 4),
            movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configure(data: MovieCellProtocol) {
        movieTitle.text = data.titleText
        movieImage.loadImage(url: data.imageURL)
    }
}
