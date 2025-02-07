//
//  MovieManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 07.02.25.
//

import Foundation

class MovieManager: MovieManagerUseCase {
    let manager = NetworkManager()
    
    func searchMovies() {
    }
    
    func getMovieList(endpoint: MovieEndpoint, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = endpoint.path
        manager.request(path: path,
                        model: Movie.self,
                        completion: completion)
    }
}
