//
//  CollectionHeader.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import UIKit

class CollectionHeader: UICollectionReusableView {
    
//    MARK: UI elements
        
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
        l.textAlignment = .center
        l.numberOfLines = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var overviewLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.numberOfLines = 6
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
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
        [backImage,
         posterImage,
         titleLabel,
         overviewLabel].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImage.widthAnchor.constraint(equalTo: widthAnchor),
            backImage.heightAnchor.constraint(equalToConstant: 210),
            backImage.topAnchor.constraint(equalTo: topAnchor),
            
            posterImage.widthAnchor.constraint(equalToConstant: 120),
            posterImage.heightAnchor.constraint(equalToConstant: 150),
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 130),
            posterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
    
    func configure(model: Collection) {
        backImage.loadImage(url: model.backdropPath ?? "")
        posterImage.loadImage(url: model.posterPath ?? "")
        titleLabel.text = model.name
        overviewLabel.text = model.overview
    }
}
