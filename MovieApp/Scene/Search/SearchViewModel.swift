//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class SearchViewModel {
    var searchedMovies = [MovieResult]()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    private let manager = SearchManager()
    
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
}
