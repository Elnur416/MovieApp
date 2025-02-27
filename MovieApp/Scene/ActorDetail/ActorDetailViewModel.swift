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
    private let useCase: ActorManagerUseCase
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    init(actorId: Int, useCase: ActorManagerUseCase) {
        self.actorId = actorId
        self.useCase = useCase
    }
    
    func getActorData() {
        useCase.getActorDetails(actorId: actorId ?? 0) { data, error in
            if let data {
                self.actorData = data
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
    
    func getActorMovies() {
        useCase.getActorMovies(actorId: self.actorId ?? 0) { data, error in
            if let data {
                self.actorMovies = data.cast ?? []
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
