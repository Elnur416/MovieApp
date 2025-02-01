//
//  MovieCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .red
    }
}
