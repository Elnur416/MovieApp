//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.03.25.
//

import Foundation
import UIKit
import FirebaseAuth

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var window: UIWindow?
    
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        if UserDefaults.standard.string(forKey: "userID") == nil {
            AuthManager.shared.signOut()
            authRoot()
        } else {
            tabRoot()
        }
    }
    
    func tabRoot() {
        let tabbar = TabBarController()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }
    
    func authRoot() {
        let controller = AuthController()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}
