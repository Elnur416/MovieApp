//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

enum MovieEndpoint: String {
    case nowPlaying = "movie/now_playing?page="
    case popular = "movie/popular?page="
    case topRated = "movie/top_rated?page="
    case upcoming = "movie/upcoming?page="
    
    var path: String {
        NetworkHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
