//
//  MovieDetailCoordinator.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.03.25.
//
import UIKit
import Foundation

final class MovieDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    var id: Int
    
    init(navigationController: UINavigationController, id: Int) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let controller = MovieDetailController(viewModel: .init(movieId: id))
        navigationController.show(controller, sender: nil)
    }
}
