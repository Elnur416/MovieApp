//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class SearchViewModel {
    var searchedMovies = [MovieResult]()
    var searchedActors = [ActorResult]()
    var searchedCollections = [Result]()
    private var genres = [GenreElement]()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    private let manager = SearchManager()
    private let genreManager = GenreManager()
    
    func fetchMovies(query: String) {
        manager.searchMovies(query: query) { data, error in
            if let data {
                self.searchedMovies = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func fetchActors(query: String) {
        manager.searchActors(query: query) { data, error in
            if let data {
                self.searchedActors = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func fetchCollections(query: String) {
        manager.searchCollections(query: query) { data, error in
            if let data {
                self.searchedCollections = data.results ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func getGenres() {
        genreManager.getGenres { data, error in
            if let data {
                self.genres = data.genres ?? []
                GenreHandler.shared.setItems(data: data.genres ?? [])
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
