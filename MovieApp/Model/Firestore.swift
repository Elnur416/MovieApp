//
//  Firestore.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 24.02.25.
//

import Foundation

struct FirestoreModel: Codable, MovieCellProtocol {
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let id: Int?
    let genres: [Int]?
    let voteAverage: Double?
    
    var formattedDate: String {
        "\(releaseDate?.prefix(4) ?? "")"
    }
    
    var titleText: String {
        "\(title ?? "") (\(releaseDate?.prefix(4) ?? ""))"
    }
    
    var cellTitle: String {
        title ?? ""
    }
    
    var imageURL: String {
        posterPath ?? ""
    }
    
    var overviewText: String {
        ""
    }
    
    var departmentText: String {
        ""
    }
    
    var cellPosterURL: String {
        posterPath ?? ""
    }
    
    var cellVoteAverage: Double {
        voteAverage ?? 0
    }
    
    var cellGenres: [Int] {
        genres ?? []
    }

    enum CodingKeys: String, CodingKey {
        case posterPath
        case releaseDate
        case title
        case id
        case genres
        case voteAverage
    }
}
