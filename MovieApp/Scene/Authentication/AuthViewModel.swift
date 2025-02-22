//
//  AuthViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 21.02.25.
//

import Foundation

class AuthViewModel {
    var success: (() -> Void)?
    var errorHandler: (() -> Void)?
    
    func handleLogin(email: String, password: String) {
        AuthManager.shared.enter(email: email,
                                 password: password) { error in
            if let error {
                self.errorHandler?()
            } else {
                self.success?()
            }
        }
    }
}
