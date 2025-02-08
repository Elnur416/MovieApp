//
//  SearchEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

enum SearchEndpoint {
    case search(movie: String)
    
    var path: String {
        switch self {
        case .search(let movie):
            return NetworkHelper.shared.configureURL(endpoint: "search/movie?query=\(movie)")
        }
    }
}
