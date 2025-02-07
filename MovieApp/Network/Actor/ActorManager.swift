//
//  ActorManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 07.02.25.
//

import Foundation

class ActorManager: ActorManagerUseCase {
    private let manager = NetworkManager()
    
    func searchActor() {
    }
    
    func getActorList(completion: @escaping ((Actor?, String?) -> Void)) {
        let path = ActorEndpoint.actor.path
        manager.request(path: path,
                        model: Actor.self,
                        completion: completion)
    }
    
    func getActorMovies(actorId: Int, completion: @escaping ((Movie?, String?) -> Void)) {
        let path = ActorEndpoint.actorMovies(id: actorId).path
        manager.request(path: path,
                        model: Movie.self,
                        completion: completion)
    }
    
   
}
