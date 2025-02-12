//
//  HeaderView.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 11.02.25.
//

import UIKit

class MovieHeaderView: UICollectionReusableView {
    
//    MARK: Properties
    
    private var movieGenres = [GenreElement]()
    private var items = ["Similar Movies", "Collection"]
    var segmentCallback: ((Int) -> Void)?
    
    //    MARK: - Setup UI elements
    
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
        l.textAlignment = .left
        l.numberOfLines = 3
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [dateView, line, voteView, line2, timeView])
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var dateView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var voteView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var timeView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var line: UILabel = {
        let l = UILabel()
        l.text = "|"
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var line2: UILabel = {
        let l = UILabel()
        l.text = "|"
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var dateImage: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "calendar"))
        i.contentMode = .scaleAspectFit
        i.tintColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var movieDate: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var voteImage: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "star.fill"))
        i.contentMode = .scaleAspectFit
        i.tintColor = UIColor(named: "starColour")
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var movieVote: UILabel = {
        let l = UILabel()
        l.textColor = UIColor(named: "starColour")
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var timeImage: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "clock"))
        i.contentMode = .scaleAspectFit
        i.tintColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var runtime: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var genreCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 4, bottom: 0, right: 0)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsHorizontalScrollIndicator = false
        c.register(GenreCell.self, forCellWithReuseIdentifier: "\(GenreCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var aboutMovie: UILabel = {
        let l = UILabel()
        l.text = "About Movie"
        l.font = .systemFont(ofSize: 17, weight: .semibold)
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var overview: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.numberOfLines = 6
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: self.items)
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        [backImage,
         posterImage,
         titleLabel,
         stack,
         genreCollection,
         aboutMovie,
         overview,
         segmentControl].forEach(addSubview)
        
        [dateImage,
         movieDate].forEach { dateView.addSubview($0) }
        
        [voteImage,
         movieVote].forEach { voteView.addSubview($0) }
        
        [timeImage,
         runtime].forEach { timeView.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImage.widthAnchor.constraint(equalTo: widthAnchor),
            backImage.heightAnchor.constraint(equalToConstant: 210),
            backImage.topAnchor.constraint(equalTo: topAnchor),
            
            posterImage.widthAnchor.constraint(equalToConstant: 120),
            posterImage.heightAnchor.constraint(equalToConstant: 150),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 130),
            
            titleLabel.topAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            stack.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 16),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.widthAnchor.constraint(equalToConstant: 274),
            
            dateView.widthAnchor.constraint(equalToConstant: 80),
            dateView.heightAnchor.constraint(equalToConstant: 32),
            
            voteView.widthAnchor.constraint(equalToConstant: 90),
            voteView.heightAnchor.constraint(equalToConstant: 32),
            
            dateImage.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 4),
            dateImage.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
            
            movieDate.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 4),
            movieDate.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor),
            
            voteImage.leadingAnchor.constraint(equalTo: voteView.leadingAnchor, constant: 8),
            voteImage.centerYAnchor.constraint(equalTo: voteView.centerYAnchor),
            
            movieVote.leadingAnchor.constraint(equalTo: voteImage.trailingAnchor, constant: 4),
            movieVote.centerYAnchor.constraint(equalTo: voteImage.centerYAnchor),
            
            timeImage.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: 8),
            timeImage.centerYAnchor.constraint(equalTo: timeView.centerYAnchor),
            
            runtime.leadingAnchor.constraint(equalTo: timeImage.trailingAnchor, constant: 4),
            runtime.centerYAnchor.constraint(equalTo: timeImage.centerYAnchor),
            
            genreCollection.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16),
            genreCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            genreCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            genreCollection.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreCollection.heightAnchor.constraint(equalToConstant: 30),
            
            aboutMovie.topAnchor.constraint(equalTo: genreCollection.bottomAnchor, constant: 24),
            aboutMovie.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            aboutMovie.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            
            overview.topAnchor.constraint(equalTo: aboutMovie.bottomAnchor, constant: 8),
            overview.leadingAnchor.constraint(equalTo: aboutMovie.leadingAnchor),
            overview.trailingAnchor.constraint(equalTo: aboutMovie.trailingAnchor),
            
            segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            segmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
        ])
    }
    
    func configure(model: MovieDetail) {
        backImage.loadImage(url: model.backdropPath ?? "")
        posterImage.loadImage(url: model.posterPath ?? "")
        titleLabel.text = model.title
        movieDate.text = model.formattedDate
        let value = model.voteAverage ?? 0
        let formattedValue = String(format: "%.1f", value)
        movieVote.text = "\(formattedValue) / 10"
        runtime.text = "\(model.runtime ?? 0) min"
        overview.text = model.overview
        
        movieGenres = model.genres ?? []
        genreCollection.reloadData()
    }
    
    @objc private func segmentChanged() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            segmentCallback?(0)
        case 1:
            segmentCallback?(1)
        default:
            return
        }
    }
}

extension MovieHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GenreCell.self)", for: indexPath) as! GenreCell
        cell.configure(genre: movieGenres[indexPath.item].name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width/4-10, height: 30)
    }
}
