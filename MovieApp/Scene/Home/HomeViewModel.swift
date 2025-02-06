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
        getNowPlaying()
        getPopular()
        getTopRated()
        getUpcoming()
    }
    
    private func getNowPlaying() {
        let path = MovieEndpoint.nowPlaying.path
        manager.request(path: path,
                        model: Movie.self) { data, error in
            if let data {
                self.movieItems.append(.init(title: "Now Playing",
                                             items: data.results ?? []))
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    private func getPopular() {
        let path = MovieEndpoint.popular.path
        manager.request(path: path,
                        model: Movie.self) { data, error in
            if let data {
                self.movieItems.append(.init(title: "Popular",
                                             items: data.results ?? []))
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    private func getTopRated() {
        let path = MovieEndpoint.topRated.path
        manager.request(path: path,
                        model: Movie.self) { data, error in
            if let data {
                self.movieItems.append(.init(title: "Top Rated",
                                             items: data.results ?? []))
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    private func getUpcoming() {
        let path = MovieEndpoint.upcoming.path
        manager.request(path: path,
                        model: Movie.self) { data, error in
            if let data {
                self.movieItems.append(.init(title: "Upcoming",
                                             items: data.results ?? []))
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
