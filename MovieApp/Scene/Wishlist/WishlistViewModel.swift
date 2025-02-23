//
//  WishlistViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 23.02.25.
//

import Foundation

class WishlistViewModel {
    private(set) var movies = [MovieDetail]()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func getMovies() {
        
    }
}
