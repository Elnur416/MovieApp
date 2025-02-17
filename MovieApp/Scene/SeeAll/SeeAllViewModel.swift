//
//  SeeAllViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import Foundation

class SeeAllViewModel {
    var selectedTitle: String?
    var movie: Movie?
    var movieItems = [MovieResult]()
    private let manager = MovieManager()
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func getMovies() {
        switch selectedTitle {
        case "Now Playing":
            fetchData(endpoint: .nowPlaying)
            case "Top Rated":
            fetchData(endpoint: .topRated)
            case "Upcoming":
            fetchData(endpoint: .upcoming)
            case "Popular":
            fetchData(endpoint: .popular)
        default:
            return
        }
    }
    
    func fetchData(endpoint: MovieEndpoint) {
        manager.getMovieList(page: ((movie?.page ?? 0) + 1), endpoint: endpoint) { data, error in
            if let data {
                self.movie = data
                self.movieItems.append(contentsOf: data.results ?? [])
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func pagination(index: Int) {
        if index == movieItems.count - 2 && movie?.page ?? 0 <= (movie?.totalPages ?? 0) {
            getMovies()
        }
    }
    
    func reset() {
        movie = nil
        movieItems.removeAll()
    }
}

