//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

enum MovieEndpoint: String {
    case nowPlaying = "movie/now_playing"
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    
    var path: String {
        NetworkHelper.shared.configureURL(enpoint: self.rawValue)
    }
}
