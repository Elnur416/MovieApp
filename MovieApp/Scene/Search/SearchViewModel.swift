//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class SearchViewModel {
    private var movie: Movie?
    var searchedMovies = [MovieResult]()
    var searchedActors = [ActorResult]()
    var searchedCollections = [Result]()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    private let useCase: SearchUseCase
    
    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }
    
    func fetchMovies(query: String) {
        useCase.searchMovies(query: query) { data, error in
            if let data {
                self.movie = data
                self.searchedMovies = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func fetchActors(query: String) {
        useCase.searchActors(query: query) { data, error in
            if let data {
                self.searchedActors = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func fetchCollections(query: String) {
        useCase.searchCollections(query: query) { data, error in
            if let data {
                self.searchedCollections = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
