//
//  TabBarController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.02.25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
    }
    
    private func configureTabs() {
        let vc1 = HomeController()
        let vc2 = SearchController()
        let vc3 = ActorController()
        
//        Set Tab Images
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "person.3")
        
//        Set Title
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Search"
        vc3.tabBarItem.title = "Actors"
        
//        Navigation Controller
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = UIColor(named: "mainColour")
        
        viewControllers = [nav1, nav2, nav3]
        setViewControllers(viewControllers, animated: true)
    }
}
