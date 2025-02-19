//
//  ActorManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 07.02.25.
//

import Foundation

class ActorManager: ActorManagerUseCase {
    private let manager = NetworkManager()
    
    func getActorDetails(actorId: Int, completion: @escaping ((ActorResult?, String?) -> Void)) {
        let path = ActorEndpoint.detail(id: actorId).path
        manager.request(path: path,
                        model: ActorResult.self,
                        completion: completion)
    }
    
    func searchActor() {
    }
    
    func getActorList(page: Int, completion: @escaping ((Actor?, String?) -> Void)) {
        let path = ActorEndpoint.actor(page: page).path
        manager.request(path: path,
                        model: Actor.self,
                        completion: completion)
    }
    
    func getActorMovies(actorId: Int, completion: @escaping ((ActorMovies?, String?) -> Void)) {
        let path = ActorEndpoint.actorMovies(id: actorId).path
        manager.request(path: path,
                        model: ActorMovies.self,
                        completion: completion)
    }
    
   
}
