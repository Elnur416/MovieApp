//
//  MovieDetailUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 09.02.25.
//

import Foundation

protocol MovieDetailUseCase {
    func getMovieDetail(id: Int, completion: @escaping((MovieDetail?, String?) -> Void))
}
