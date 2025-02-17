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
    
    func getMovieList(page: Int, endpoint: MovieEndpoint, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = endpoint.path + "\(page)"
        manager.request(path: path,
                        model: Movie.self,
                        completion: completion)
    }
}
