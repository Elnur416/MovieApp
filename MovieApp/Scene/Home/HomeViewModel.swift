//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import Foundation

enum HomeSectionTitle: String {
    case popular = "Popular"
    case upcoming = "Upcoming"
    case toprated = "Top Rated"
    case nowplaying = "Now Playing"
}

struct HomeTitleModel {
    let type: HomeSectionTitle
    let endpoint: MovieEndpoint
}

struct HomeModel {
    let title: HomeTitleModel
    var items: [MovieResult]
}

class HomeViewModel {
    var movieItems = [HomeModel]()
    let useCase: MovieManagerUseCase
    private let genreUseCase: GenreUseCase
    private var genres = [GenreElement]()
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    init(useCase: MovieManagerUseCase, genreUseCase: GenreUseCase) {
        self.useCase = useCase
        self.genreUseCase = genreUseCase
    }
    
    func getAllData() {
        fetchData(title: .init(type: .nowplaying, endpoint: .nowPlaying))
        fetchData(title: .init(type: .popular, endpoint: .popular))
        fetchData(title: .init(type: .toprated, endpoint: .topRated))
        fetchData(title: .init(type: .upcoming, endpoint: .upcoming))
    }
    
    private func fetchData(title: HomeTitleModel) {
        useCase.getMovieList(page: 1, endpoint: title.endpoint) { data, error in
            if let data {
                self.movieItems.append(.init(title: title,
                                             items: data.results ?? []))
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func getGenres() {
        genreUseCase.getGenres { data, error in
            if let data {
                self.genres = data.genres ?? []
                GenreHandler.shared.setItems(data: data.genres ?? [])
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
