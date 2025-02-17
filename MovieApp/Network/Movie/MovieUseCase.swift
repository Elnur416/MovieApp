//
//  MovieUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 07.02.25.
//

import Foundation

protocol MovieManagerUseCase {
    func searchMovies()
    func getMovieList(page: Int, endpoint: MovieEndpoint, completion: @escaping((Movie?, String?) -> Void))
}
