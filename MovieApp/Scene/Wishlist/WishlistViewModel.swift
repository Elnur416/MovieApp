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
    
    func getData() {
        FirestoreManager.shared.getDocument { data, error in
            if let error {
                self.errorHandler?(error)
            } else if let data {
                self.movies = data
                self.success?()
            }
        }
    }
    
    func reset() {
        movies.removeAll()
    }
}
