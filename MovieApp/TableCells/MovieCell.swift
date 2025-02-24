//
//  TableCell.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import UIKit

class MovieCell: UITableViewCell {
    
    private var movieGenres = [String]()
    
//    MARK: UI elements
    
    private lazy var movieImage: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 16
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var movieName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var starImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "star.fill")
        i.tintColor = UIColor(named: "starColour")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var imdbRating: UILabel = {
       let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = UIColor(named: "starColour")
        l.numberOfLines = 0
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
    
    private lazy var calendarImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "calendar")
        i.tintColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var releaseDate: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .gray
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
//    MARK: - Life cycle

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
        [movieName,
         movieImage,
         starImage,
         imdbRating,
         collection,
         calendarImage,
         releaseDate].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: 120),
            movieImage.widthAnchor.constraint(equalToConstant: 95),
            movieImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            movieImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            movieName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            starImage.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 8),
            starImage.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            starImage.heightAnchor.constraint(equalToConstant: 16),
            starImage.widthAnchor.constraint(equalToConstant: 16),
            
            imdbRating.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            imdbRating.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 8),
            
            collection.topAnchor.constraint(equalTo: starImage.bottomAnchor, constant: 8),
            collection.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.heightAnchor.constraint(equalToConstant: 30),
            
            calendarImage.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 8),
            calendarImage.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 16),
            calendarImage.heightAnchor.constraint(equalToConstant: 16),
            calendarImage.widthAnchor.constraint(equalToConstant: 16),
            
            releaseDate.centerYAnchor.constraint(equalTo: calendarImage.centerYAnchor),
            releaseDate.leadingAnchor.constraint(equalTo: calendarImage.trailingAnchor, constant: 8),
            releaseDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
//    MARK: - Configure
    
    func configure(model: MovieCellProtocol) {
        movieName.text = model.cellTitle
        movieImage.loadImage(url: model.cellPosterURL)
        
        let value = model.cellVoteAverage
        let formattedValue = String(format: "%.1f", value)
        imdbRating.text = "\(formattedValue) / 10"
        
        releaseDate.text = model.formattedDate
        movieGenres = GenreHandler.shared.getGenreName(id: model.cellGenres)
        collection.reloadData()
    }
}

//MARK: - Setup collection

extension MovieCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GenreCell.self)", for: indexPath) as! GenreCell
        cell.configure(genre: movieGenres[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/4-10, height: 30)
    }
}
