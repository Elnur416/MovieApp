//
//  TableCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import UIKit

class TableCell: UITableViewCell {
    
    private lazy var movieImage: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .orange
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var movieName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17, weight: .bold)
        l.text = "aluegca"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        [movieName,
         movieImage].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            movieImage.widthAnchor.constraint(equalToConstant: 150),
            movieImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            
            movieName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16)
        ])
    }
}
