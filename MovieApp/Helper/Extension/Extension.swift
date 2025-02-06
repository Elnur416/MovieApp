//
//  Extension.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 05.02.25.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func loadImage(url: String) {
        let fullPath = NetworkHelper.shared.imageBaseURL + url
        guard let url = URL(string: fullPath) else { return }
        self.sd_setImage(with: url)
    }
}
