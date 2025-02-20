//
//  AuthViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 21.02.25.
//

import Foundation

class AuthViewModel {
    func handleLogin(email: String, password: String) {
        let auth = AuthManager.shared
        auth.signIn(email: email,
                    password: password) { result, error in
            if let result {
                print(result)
            } else if let error {
                print(error.localizedDescription)
                self.createAccount(email: email, password: password)
            }
        }
    }
        
    private func createAccount(email: String, password: String) {
        let auth = AuthManager.shared
        auth.createUser(email: email,
                        password: password) { result, error in
            if let result {
                print(result)
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
}
