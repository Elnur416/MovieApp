//
//  ActorViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

class ActorViewModel {
    var actors = [ActorResult]()
    private let manager = ActorManager()
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func fetchActors() {
        manager.getActorList { data, error in
            if let data {
                self.actors = data.results ?? []
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
