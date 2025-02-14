//
//  ActorEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

enum ActorEndpoint {
    case actor(page: Int)
    case detail(id: Int)
    case actorMovies(id: Int)
    
    var path: String {
        switch self {
        case .actor(let page):
            return NetworkHelper.shared.configureURL(endpoint: "person/popular?page=\(page)")
        case .detail(let id):
            return NetworkHelper.shared.configureURL(endpoint: "person/\(id)")
        case .actorMovies(let id):
            return NetworkHelper.shared.configureURL(endpoint: "person/\(id)/movie_credits")
        }
    }
}
