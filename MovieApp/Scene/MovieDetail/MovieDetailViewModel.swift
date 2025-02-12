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
    var collection: BelongsToCollection?
    var segmentIndex: Int? = 0
    var movieId: Int?
    private let detailManager = MovieDetailManager()
    private let similarManager = SimilarManager()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
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
}
