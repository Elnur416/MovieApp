//
//  ActorEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

enum ActorEndpoint {
    case actor
    case actorMovies(id: Int)
    
    var path: String {
        switch self {
        case .actor:
            return NetworkHelper.shared.configureURL(endpoint: "person/popular")
        case .actorMovies(let id):
            return NetworkHelper.shared.configureURL(endpoint: "person/\(id)/movie_credits")
        }
    }
}
