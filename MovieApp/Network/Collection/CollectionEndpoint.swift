//
//  CollectionEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import Foundation

enum CollectionEndpoint {
    case collection( id: Int)
    
    var path: String {
        switch self {
        case .collection(let id):
            return NetworkHelper.shared.configureURL(endpoint: "collection/\(id)")
        }
    }
}
