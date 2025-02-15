//
//  Navigation.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 15.02.25.
//

import Foundation
import UIKit

extension UINavigationController {
    public override var navigationController: UINavigationController? {
        navigationBar.tintColor = UIColor(named: "mainColour")
        return self
    }
}
