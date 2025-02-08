//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 03.02.25.
//

import UIKit
import SDWebImage

class MovieDetailController: UIViewController {
    
    let viewModel = MovieDetailViewModel()
    
//    MARK: Setup UI elements
    
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
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [dateView, line, voteView])
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var dateView: UIView = {
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
    
    private lazy var voteView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
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
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var voteImage: UIImageView = {
        let i = UIImageView(image: UIImage(systemName: "star.fill"))
        i.contentMode = .scaleAspectFit
        i.tintColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var movieVote: UILabel = {
        let l = UILabel()
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var aboutMovie: UILabel = {
        let l = UILabel()
        l.text = "About Movie"
        l.font = .systemFont(ofSize: 17, weight: .semibold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var overview: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 17, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        setupData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        [backImage,
         posterImage,
         titleLabel,
         stack,
         aboutMovie,
         overview].forEach { view.addSubview($0) }
        
        [dateImage,
         movieDate].forEach { dateView.addSubview($0) }
        
        [voteImage,
         movieVote].forEach { voteView.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            backImage.heightAnchor.constraint(equalToConstant: 210),
            backImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            posterImage.widthAnchor.constraint(equalToConstant: 120),
            posterImage.heightAnchor.constraint(equalToConstant: 150),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            
            titleLabel.topAnchor.constraint(equalTo: backImage.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            stack.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 16),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dateView.widthAnchor.constraint(equalToConstant: 80),
            dateView.heightAnchor.constraint(equalToConstant: 32),
            
            voteView.widthAnchor.constraint(equalToConstant: 80),
            voteView.heightAnchor.constraint(equalToConstant: 32),
            
            dateImage.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: 4),
            dateImage.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
            
            movieDate.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 4),
            movieDate.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor),
            
            voteImage.leadingAnchor.constraint(equalTo: voteView.leadingAnchor, constant: 8),
            voteImage.centerYAnchor.constraint(equalTo: voteView.centerYAnchor),
            
            movieVote.leadingAnchor.constraint(equalTo: voteImage.trailingAnchor, constant: 4),
            movieVote.centerYAnchor.constraint(equalTo: voteImage.centerYAnchor),
            
            aboutMovie.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 24),
            aboutMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            overview.topAnchor.constraint(equalTo: aboutMovie.bottomAnchor, constant: 24),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
    
    private func setupData() {
        backImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(self.viewModel.data?.backdropPath ?? "")")) { image, error, _, _ in
            if let image {
                self.backImage.image = image
            } else if let error {
                print(error)
            }
        }
        posterImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(self.viewModel.data?.posterPath ?? "")")) { image, error, _, _ in
            if let image {
                self.posterImage.image = image
            } else if let error {
                print(error)
            }
        }
        titleLabel.text = viewModel.data?.title
        movieDate.text = "\(viewModel.data?.releaseDate?.prefix(4) ?? "")"
        let value = viewModel.data?.voteAverage ?? 0
        let formattedValue = String(format: "%.1f", value)
        movieVote.text = formattedValue
        overview.text = viewModel.data?.overview
    }
}
