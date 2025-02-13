//
//  VideoEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 13.02.25.
//

import Foundation

enum VideoEndpoint {
    case video(id: Int)
    
    var path: String {
        switch self {
            case .video(let id):
            NetworkHelper.shared.configureURL(endpoint: "movie/\(id)/videos")
        }
    }
}
