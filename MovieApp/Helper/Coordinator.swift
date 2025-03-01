//
//  Coordinator.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.03.25.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
}
