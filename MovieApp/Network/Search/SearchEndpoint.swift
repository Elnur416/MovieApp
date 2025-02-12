//
//  SearchEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

enum SearchEndpoint {
    case movie(movie: String)
    case actor(actor: String)
    case collection(collection: String)
    
    var path: String {
        switch self {
        case .movie(let movie):
            return NetworkHelper.shared.configureURL(endpoint: "search/movie?query=\(movie)")
        case .actor(let actor):
            return NetworkHelper.shared.configureURL(endpoint: "search/person?query=\(actor)")
        case .collection(let collection):
            return NetworkHelper.shared.configureURL(endpoint: "search/collection?query=\(collection)")
        }
    }
}
