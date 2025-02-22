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
        let vc4 = WishListController()
        
//        Set Tab Images
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "person.3")
        vc4.tabBarItem.image = UIImage(systemName: "bookmark")
        
//        Set Title
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Search"
        vc3.tabBarItem.title = "Actors"
        vc4.tabBarItem.title = "Wishlist"
        
//        Navigation Controller
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = UIColor(named: "mainColour")
        
        viewControllers = [nav1, nav2, nav3, nav4]
        setViewControllers(viewControllers, animated: true)
    }
}
