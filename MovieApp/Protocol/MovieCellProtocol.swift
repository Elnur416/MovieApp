//
//  MovieCellProtocol.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

protocol MovieCellProtocol {
    var titleText: String { get }
    var imageURL: String { get }
    var overviewText: String { get }
    var departmentText: String { get }
}
