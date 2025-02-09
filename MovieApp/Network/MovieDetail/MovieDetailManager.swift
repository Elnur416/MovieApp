//
//  MovieDetailManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 09.02.25.
//

import Foundation

class MovieDetailManager: MovieDetailUseCase {
    private let manager = NetworkManager()
    
    func getMovieDetail(id: Int, completion: @escaping ((MovieDetail?, String?) -> Void)) {
        let path = MovieDetailEndpoint.detail(id: id).path
        manager.request(path: path,
                        model: MovieDetail.self,
                        completion: completion)
    }
}
