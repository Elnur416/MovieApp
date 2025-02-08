//
//  GenreHandler.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

class GenreHandler {
    static let shared = GenreHandler()
    private var genres = [Int?: String?]()
    
    func setItems(data: [GenreElement]) {
        self.genres = Dictionary(uniqueKeysWithValues: data.map { ($0.id, $0.name) })
    }
    
    func getGenreName(id: [Int]) -> [String] {
        return id.compactMap { genres[$0] ?? "" }
    }
}
