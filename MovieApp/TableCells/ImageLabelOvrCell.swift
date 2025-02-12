//
//  ImageLabelOvrCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import UIKit

class ImageLabelOvrCell: UITableViewCell {
    
    private var department: String?
    
    private lazy var titleImage: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 16
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsHorizontalScrollIndicator = false
        c.register(GenreCell.self, forCellWithReuseIdentifier: "\(GenreCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var overview: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 10, weight: .regular)
        l.numberOfLines = 6
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
        selectionStyle = .none
        [titleImage,
         titleLabel,
         collection,
         overview].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalToConstant: 120),
            titleImage.widthAnchor.constraint(equalToConstant: 95),
            titleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            titleImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: titleImage.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collection.leadingAnchor.constraint(equalTo: titleImage.trailingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.heightAnchor.constraint(equalToConstant: 30),
            
            overview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            overview.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    func configure(model: MovieCellProtocol, collectionHidden: Bool) {
        titleImage.loadImage(url: model.imageURL)
        titleLabel.text = model.titleText
        overview.text = model.overviewText
        
        collection.isHidden = collectionHidden
        department = model.departmentText
        collection.reloadData()
    }
}

extension ImageLabelOvrCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GenreCell.self)", for: indexPath) as! GenreCell
        cell.configure(genre: department ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/4-10, height: 30)
    }
}
