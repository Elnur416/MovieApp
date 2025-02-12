//
//  SearchManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class SearchManager: SearchUseCase {
    private let manager = NetworkManager()
    
    func searchMovies(query: String, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = SearchEndpoint.movie(movie: query).path
        manager.request(path: path,
                        model: Movie.self,
                        completion: completion)
    }
    
    func searchActors(query: String, completion: @escaping ((Actor?, String?) -> Void)) {
        let path = SearchEndpoint.actor(actor: query).path
        manager.request(path: path,
                        model: Actor.self,
                        completion: completion)
    }
    
    func searchCollections(query: String, completion: @escaping ((CollectionSearch?, String?) -> Void)) {
        let path = SearchEndpoint.collection(collection: query).path
        manager.request(path: path,
                        model: CollectionSearch.self,
                        completion: completion)
    }
}
