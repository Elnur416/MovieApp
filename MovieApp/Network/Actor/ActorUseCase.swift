//
//  ActorUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 07.02.25.
//

import Foundation

protocol ActorManagerUseCase {
    func searchActor()
    func getActorList(completion: @escaping((Actor?, String?) -> Void))
    func getActorMovies(actorId: Int, completion: @escaping((Movie?, String?) -> Void))
}
