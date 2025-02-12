//
//  SearchUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

protocol SearchUseCase {
    func searchMovies(query: String, completion: @escaping ((Movie?, String?) -> Void))
    func searchActors(query: String, completion: @escaping ((Actor?, String?) -> Void))
    func searchCollections(query: String, completion: @escaping ((CollectionSearch?, String?) -> Void))
}
