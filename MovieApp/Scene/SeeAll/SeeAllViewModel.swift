//
//  SeeAllViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import Foundation

class SeeAllViewModel {
    private var movie: Movie?
    var model: HomeModel
    private var usecase: MovieManagerUseCase
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    init(model: HomeModel, usecase: MovieManagerUseCase) {
        self.model = model
        self.usecase = usecase
    }
    
    func fetchData() {
        usecase.getMovieList(page: ((movie?.page ?? 0) + 1), endpoint: model.title.endpoint) { data, error in
            if let data {
                self.movie = data
                self.model.items.append(contentsOf: data.results ?? [])
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func pagination(index: Int) {
        if index == model.items.count - 2 && movie?.page ?? 0 <= (movie?.totalPages ?? 0) {
            fetchData()
        }
    }
    
    func reset() {
        movie = nil
        model.items.removeAll()
    }
}

