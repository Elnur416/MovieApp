//
//  Collection.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import Foundation

// MARK: - Collection
struct Collection: Codable {
    let id: Int?
    let name, overview, posterPath, backdropPath: String?
    let parts: [MovieResult]?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case parts
    }
}
