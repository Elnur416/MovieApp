//
//  CollectionSearch.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import Foundation

// MARK: - Collection
struct CollectionSearch: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable, MovieCellProtocol {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let name, originalLanguage, originalName, overview: String?
    let posterPath: String?
    
    
    var titleText: String {
        name ?? ""
    }
    
    var cellTitle: String {
        name ?? ""
    }
    
    var imageURL: String {
        posterPath ?? ""
    }
    
    var overviewText: String {
        overview ?? ""
    }
    
    var departmentText: String {
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
    
    var cellPosterURL: String {
        ""
    }
    
    var formattedDate: String {
        ""
    }


    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
    }
}
