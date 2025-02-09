//
//  SimilarManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 09.02.25.
//

import Foundation

class SimilarManager: SimilarUseCase {
    private let manager = NetworkManager()
    
    func getSimilarMovies(movieId: Int, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = SimilarEndpoint.similarMovie(id: movieId).path
        manager.request(path: path,
                        model: Movie.self,
                        completion: completion)
    }
}
