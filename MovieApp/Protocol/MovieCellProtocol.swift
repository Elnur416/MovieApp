//
//  MovieCellProtocol.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

protocol MovieCellProtocol {
    var titleText: String { get }
    var cellTitle: String { get }
    var imageURL: String { get }
    var overviewText: String { get }
    var departmentText: String { get }
    var cellPosterURL: String { get }
    var cellVoteAverage: Double { get }
    var formattedDate: String { get }
    var cellGenres: [Int] { get }
}
