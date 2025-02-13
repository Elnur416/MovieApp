//
//  ActorHeaderView.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 11.02.25.
//

import UIKit

class ActorHeaderView: UICollectionReusableView {
    
    private var department: String?
    
//    MARK: UI elements
    
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
        l.textAlignment = .left
        l.text = "Atqkhd akehfake"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var placeLabel: UILabel = {
        let l = UILabel()
        l.text = "London, England, UK"
        l.font = .systemFont(ofSize: 17, weight: .regular)
        l.textColor = UIColor(named: "mainColour")
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var genreCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsHorizontalScrollIndicator = false
        c.register(GenreCell.self, forCellWithReuseIdentifier: "\(GenreCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var aboutActor: UILabel = {
        let l = UILabel()
        l.text = "About actor"
        l.font = .systemFont(ofSize: 17, weight: .semibold)
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var biography: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.numberOfLines = 6
        l.textAlignment = .left
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
        [actorImage,
         actorName,
         placeLabel,
         genreCollection,
         aboutActor,
         biography,
         knownLabel].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            actorImage.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            actorImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            actorImage.widthAnchor.constraint(equalToConstant: 120),
            actorImage.heightAnchor.constraint(equalToConstant: 150),
            
            actorName.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            actorName.leadingAnchor.constraint(equalTo: actorImage.trailingAnchor, constant: 32),
            actorName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            placeLabel.topAnchor.constraint(equalTo: actorName.bottomAnchor, constant: 16),
            placeLabel.leadingAnchor.constraint(equalTo: actorImage.trailingAnchor, constant: 32),
            placeLabel.trailingAnchor.constraint(equalTo: actorName.trailingAnchor),
            
            genreCollection.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 16),
            genreCollection.leadingAnchor.constraint(equalTo: actorName.leadingAnchor),
            genreCollection.trailingAnchor.constraint(equalTo: actorName.trailingAnchor),
            genreCollection.heightAnchor.constraint(equalToConstant: 30),
            
            aboutActor.topAnchor.constraint(equalTo: actorImage.bottomAnchor, constant: 24),
            aboutActor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            aboutActor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            
            biography.topAnchor.constraint(equalTo: aboutActor.bottomAnchor, constant: 16),
            biography.leadingAnchor.constraint(equalTo: aboutActor.leadingAnchor),
            biography.trailingAnchor.constraint(equalTo: aboutActor.trailingAnchor),
            
            knownLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            knownLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            knownLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
    
//    MARK: - Configure
    
    func configure(model: ActorDetail) {
        actorImage.loadImage(url: model.profilePath ?? "")
        actorName.text = model.name
        placeLabel.text = model.placeOfBirth
        biography.text = model.biography
        self.department = model.knownForDepartment
        genreCollection.reloadData()
    }
}

//MARK: - Setup collection

extension ActorHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GenreCell.self)", for: indexPath) as! GenreCell
        cell.configure(genre: department ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/2, height: 30)
    }
}
