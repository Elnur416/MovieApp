//
//  SearchManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class SearchManager: SearchUseCase {
    private let manager = NetworkManager()
    
    func getSearchResults(query: String, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = SearchEndpoint.search(movie: query).path
        manager.request(path: path,
                        model: Movie.self, completion: completion)
    }
}
