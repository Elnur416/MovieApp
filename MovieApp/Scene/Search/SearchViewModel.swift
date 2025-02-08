//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class SearchViewModel {
    var searchedMovies = [MovieResult]()
    private var genres = [GenreElement]()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    private let manager = SearchManager()
    private let genreManager = GenreManager()
    
    func fetchMovies(query: String) {
        manager.getSearchResults(query: query) { data, error in
            if let data {
                self.searchedMovies = data.results ?? []
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
