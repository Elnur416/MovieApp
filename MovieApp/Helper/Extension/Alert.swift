//
//  Alert.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 22.02.25.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String = "Error",
                   message: String? = nil,
                   actionTitle: String = "Ok") {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        controller.addAction(action)
        present(controller, animated: true)
    }
}
