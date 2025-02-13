//
//  GenreCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
//    MARK: UI elements
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemGray5
        addSubview(genreLabel)
        genreLabel.frame = bounds
        layer.cornerRadius = 8
    }
    
//    MARK: - Configure
    
    func configure(genre: String) {
        genreLabel.text = genre
    }
}
