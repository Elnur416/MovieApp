//
//  VideoUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 13.02.25.
//

import Foundation

protocol VideoUseCase {
    func getVideos(movieId: Int, completion: @escaping((Videos?, String?) -> Void))
}
