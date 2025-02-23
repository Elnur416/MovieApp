//
//  Actoe.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

// MARK: - Actor
struct Actor: Codable {
    let page: Int?
    let results: [ActorResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - ActorResult
struct ActorResult: Codable, MovieCellProtocol {
//    Main
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let knownFor: [KnownFor]?
    
//    ActorDetail
    let alsoKnownAs: [String]?
    let biography, birthday, deathday: String?
    let homepage: String?
    let imdbID: String?
    let placeOfBirth: String?
    
//    Protocol
    var titleText: String {
        name ?? ""
    }
    
    var imageURL: String {
        profilePath ?? ""
    }
    
    var overviewText: String {
        ""
    }
    
    var departmentText: String {
        knownForDepartment ?? ""
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
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, homepage
        case imdbID = "imdb_id"
        case placeOfBirth = "place_of_birth"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath: String?
    let id: Int?
    let title, originalTitle, overview, posterPath: String?
    let mediaType: String?
    let adult: Bool?
    let originalLanguage: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName, firstAirDate: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}
