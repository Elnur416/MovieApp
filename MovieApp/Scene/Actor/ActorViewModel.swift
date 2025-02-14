//
//  ActorViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

class ActorViewModel {
    private var actor: Actor?
    var actors = [ActorResult]()
    private let manager = ActorManager()
    var completion: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func fetchActors() {
        manager.getActorList(page: (actor?.page ?? 0) + 1) { data, error in
            if let data {
                self.actor = data
                self.actors.append(contentsOf: data.results ?? [])
                self.completion?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func pagination(index: Int) {
        if index == actors.count - 2 && (actor?.page ?? 0) <= (actor?.totalPages ?? 0) {
            fetchActors()
        }
    }
    
    func reset() {
        actor = nil
        actors.removeAll()
    }
}
