//
//  VideoManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 13.02.25.
//

import Foundation

class VideoManager: VideoUseCase {
    private let manager = NetworkManager()
    
    func getVideos(movieId: Int, completion: @escaping ((Videos?, String?) -> Void)) {
        let path = VideoEndpoint.video(id: movieId).path
        manager.request(path: path,
                        model: Videos.self,
                        completion: completion)
    }
}
