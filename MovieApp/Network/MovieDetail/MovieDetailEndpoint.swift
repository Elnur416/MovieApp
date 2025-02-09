//
//  MovieDetailEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 09.02.25.
//

import Foundation

enum MovieDetailEndpoint {
    case detail(id: Int)
    
    var path: String {
        switch self {
        case .detail(let id):
            return NetworkHelper.shared.configureURL(endpoint: "movie/\(id)")
        }
    }
}
