//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 03.02.25.
//

import Foundation

class MovieDetailViewModel {
    var data: MovieDetail?
    var similarMovies = [MovieResult]()
    var video = [VideoResult]()
    var wishlist = [FirestoreModel]()
    var collection: BelongsToCollection?
    var segmentIndex: Int? = 0
    var movieId: Int?
    let detailManager = MovieDetailManager()
    let similarManager = SimilarManager()
    private let videoManager =  VideoManager()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func getMovieDetail() {
        detailManager.getMovieDetail(id: self.movieId ?? 0) { data, error in
            if let data {
                self.data = data
                self.collection = data.belongsToCollection
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func getSimilarMovies() {
        similarManager.getSimilarMovies(movieId: self.movieId ?? 0) { data, error in
            if let data {
                self.similarMovies = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func getVideos() {
        videoManager.getVideos(movieId: movieId ?? 0) { data, error in
            if let data {
                self.video = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func getMoviesFromWishlist() {
        FirestoreManager.shared.getDocument { data, error in
            if let error {
                self.errorHandler?(error)
            } else if let data {
                self.wishlist = data
                self.success?()
            }
        }
    }
}
