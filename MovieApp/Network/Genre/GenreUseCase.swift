//
//  GenreUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

protocol GenreUseCase {
    func getGenres(completion: @escaping((Genre?, String?) -> Void)) 
}
