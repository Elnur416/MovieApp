//
//  ActorDetailViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 10.02.25.
//

import Foundation

class ActorDetailViewModel {
    var actorData: ActorResult?
    var actorMovies = [Cast]()
    var actorId: Int?
    private let manager = ActorManager()
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func getActorData() {
        manager.getActorDetails(actorId: actorId ?? 0) { data, error in
            if let data {
                self.actorData = data
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func getActorMovies() {
        manager.getActorMovies(actorId: self.actorId ?? 0) { data, error in
            if let data {
                self.actorMovies = data.cast ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
