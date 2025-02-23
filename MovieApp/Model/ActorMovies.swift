//
//  Model.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 02.02.25.
//

import Foundation

// MARK: - ActorMovies
struct ActorMovies: Codable {
    let cast, crew: [Cast]?
    let id: Int?
}

// MARK: - Cast
struct Cast: Codable, MovieCellProtocol {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let character, creditID: String?
    let order: Int?
    let department: String?
    let job: String?
    
    
    var departmentText: String {
        ""
    }
    
    var titleText: String {
        "\(title ?? "") (\(releaseDate?.prefix(4) ?? ""))"
    }
    
    var imageURL: String {
        posterPath ?? ""
    }
    
    var overviewText: String {
        ""
    }
    
    var cellVoteAverage: Double {
        0
    }
    
    var cellReleaseDate: String {
        ""
    }
    
    var cellGenres: [Int] {
        []
    }
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

enum Department: String, Codable {
    case crew = "Crew"
    case directing = "Directing"
    case production = "Production"
    case writing = "Writing"
}
enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case fr = "fr"
    case it = "it"
    case ja = "ja"
}
