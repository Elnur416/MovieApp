//
//  GenreEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

enum GenreEndpoint: String {
    case genre = "genre/movie/list"
    
    var path: String {
        NetworkHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
