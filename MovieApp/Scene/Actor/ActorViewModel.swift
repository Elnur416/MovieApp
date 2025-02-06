//
//  ActorViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

class ActorViewModel {
    var actors = [ActorData]()
    private let manager = NetworkManager()
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func fetchActors() {
        let path = ActorEndpoint.actor.path
        manager.request(path: path,
                        model: Actor.self) { data, error in
            if let data {
                self.actors = data.results ?? []
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
