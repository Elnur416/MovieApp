//
//  MovieUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 07.02.25.
//

import Foundation

protocol MovieManagerUseCase {
    func searchMovies()
    func getMovieList(endpoint: MovieEndpoint, completion: @escaping((Movie?, String?) -> Void))
}
