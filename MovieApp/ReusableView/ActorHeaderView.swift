//
//  ActorHeaderView.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 11.02.25.
//

import UIKit

class ActorHeaderView: UICollectionReusableView {
    
    private lazy var actorImage: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.layer.cornerRadius = 10
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var actorName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textColor = .black
        l.numberOfLines = 0
        l.textAlignment = .center
        l.text = "Atqkhd akehfake"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var knownLabel: UILabel = {
        let l = UILabel()
        l.text = "Known for"
        l.font = .systemFont(ofSize: 17, weight: .semibold)
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
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
        [actorImage,
         actorName,
         knownLabel].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            actorImage.topAnchor.constraint(equalTo: topAnchor),
            actorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            actorImage.widthAnchor.constraint(equalToConstant: 350),
            actorImage.heightAnchor.constraint(equalToConstant: 350),
            
            actorName.topAnchor.constraint(equalTo: actorImage.bottomAnchor, constant: 20),
            actorName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            actorName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            knownLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            knownLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            knownLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
    
    func configure(model: ActorDetail) {
        actorImage.loadImage(url: model.profilePath ?? "")
        actorName.text = model.name
    }
}
