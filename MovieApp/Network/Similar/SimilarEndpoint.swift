//
//  SimilarEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 09.02.25.
//

import Foundation

enum SimilarEndpoint {
    case similarMovie(id: Int)
    
    var path: String {
        switch self {
        case .similarMovie(let id):
            return NetworkHelper.shared.configureURL(endpoint: "movie/\(id)/similar")
        }
    }
}
