//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import Foundation

struct HomeModel {
    let title: String
    let items: [MovieResult]
}

class HomeViewModel {
    var movieItems = [HomeModel]()
    private let manager = NetworkManager()
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func getAllData() {
        fetchData(title: "Now Playing", endpoint: .nowPlaying)
        fetchData(title: "Popular", endpoint: .popular)
        fetchData(title: "Top Rated", endpoint: .topRated)
        fetchData(title: "Upcoming", endpoint: .upcoming)
    }
    
    private func fetchData(title: String, endpoint: MovieEndpoint) {
        let path = endpoint.path
        manager.request(path: path,
                        model: Movie.self) { data, error in
            if let data {
                self.movieItems.append(.init(title: title,
                                             items: data.results ?? []))
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
