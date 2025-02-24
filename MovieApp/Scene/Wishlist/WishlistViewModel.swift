//
//  WishlistViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 23.02.25.
//

import Foundation

class WishlistViewModel {
    var movies = [FirestoreModel]()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func getMovies() {
        FirestoreManager.shared.getDocument { data, error in
            if let data {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movie = try decoder.decode(FirestoreModel.self, from: jsonData)
                    if self.movies.contains(where: { $0.id == movie.id }) {
                        self.success?()
                    } else {
                        self.movies.append(movie)
                        self.success?()
                    }
                } catch {
                    self.errorHandler?(error.localizedDescription)
                }
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
