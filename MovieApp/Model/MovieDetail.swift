//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 09.02.25.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable, MovieCellProtocol {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [GenreElement]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
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
    
    var cellGenres: [Int] {
        genres?.compactMap { $0.id } ?? []
    }
    
    var cellVoteAverage: Double {
        voteAverage ?? 0
    }
    
    var cellReleaseDate: String {
        "\(releaseDate?.prefix(4) ?? "")"
    }
    
    var cellPosterURL: String {
        posterPath ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable, MovieCellProtocol {
    let id: Int?
    let name, posterPath, backdropPath: String?
    
    var cellVoteAverage: Double {
        0
    }
    
    var cellTitle: String {
        ""
    }
    
    var cellPosterURL: String {
        posterPath ?? ""
    }
    
    var cellReleaseDate: String {
        ""
    }
    
    var cellGenres: [Int] {
        []
    }
    
    var formattedDate: String {
        ""
    }
    
    var titleText: String {
        name ?? ""
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
    

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
