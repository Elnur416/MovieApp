//
//  GenreManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class GenreManager: GenreUseCase {
    let manager = NetworkManager()
    
    func getGenres(completion: @escaping ((Genre?, String?) -> Void)) {
        let path = GenreEndpoint.genre.path
        
        manager.request(path: path,
                        model: Genre.self,
                        completion: completion)
    }
}
