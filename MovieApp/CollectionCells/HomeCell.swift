//
//  HomeCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.02.25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
// MARK: Properties
    
    private var data = [MovieResult]()
    var seeAllCallback: (() -> Void)?
    var movieCallback: ((Int) -> Void)?
    
//    MARK: - Setup UI elements
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var seeAllButton: UIButton = {
        let b = UIButton()
        b.setTitle("See all", for: .normal)
        b.setTitleColor(UIColor(named: "mainColour"), for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 16)
        b.addTarget(self, action: #selector(seeAllAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsHorizontalScrollIndicator = false
        c.register(ImageLabelCell.self, forCellWithReuseIdentifier: "\(ImageLabelCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
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
        [titleLabel,
         seeAllButton,
         collection].forEach(addSubview)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            seeAllButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func seeAllAction() {
        seeAllCallback?()
    }
    
//    MARK: - Configure
    
    func configure(text: String, data: [MovieResult]) {
        titleLabel.text = text
        self.data = data
    }
}

//MARK: - Setup collection

extension HomeCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
        cell.configure(data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieCallback?(data[indexPath.row].id ?? 0)
    }
}
