//
//  ActorUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 07.02.25.
//

import Foundation

protocol ActorManagerUseCase {
    func searchActor()
    func getActorList(page: Int, completion: @escaping((Actor?, String?) -> Void))
    func getActorDetails(actorId: Int, completion: @escaping((ActorResult?, String?) -> Void))
    func getActorMovies(actorId: Int, completion: @escaping((ActorMovies?, String?) -> Void))
}
