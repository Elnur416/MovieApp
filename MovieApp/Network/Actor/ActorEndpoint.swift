//
//  ActorEndpoint.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 06.02.25.
//

import Foundation

enum ActorEndpoint: String {
    case actor = "person/popular"
    
    var path: String {
        NetworkHelper.shared.configureURL(enpoint: self.rawValue)
    }
}
