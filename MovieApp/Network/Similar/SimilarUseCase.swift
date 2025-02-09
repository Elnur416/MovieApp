//
//  SimilarUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 09.02.25.
//

import Foundation

protocol SimilarUseCase {
    func getSimilarMovies(movieId: Int, completion: @escaping((Movie?, String?) -> Void))
}
