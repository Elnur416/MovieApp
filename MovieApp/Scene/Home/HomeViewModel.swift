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
        manager.request(endpoint: .nowPlaying,
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
        manager.request(endpoint: .popular,
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
        manager.request(endpoint: .topRated,
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
        manager.request(endpoint: .upcoming,
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
    
    func filterMovies(title: String) -> [HomeModel] {
        let data = self.movieItems.filter { $0.title == title }
        return data
    }
}
