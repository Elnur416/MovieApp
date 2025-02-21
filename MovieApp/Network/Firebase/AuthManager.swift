//
//  AuthManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 20.02.25.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func createUser(email: String,
                    password: String,
                    completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { result, error in
            if let error {
                completion(nil, error)
                return
            } else if let result {
                completion(result, nil)
            }
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            if let error {
                completion(nil, error)
                return
            } else if let result {
                completion(result, nil)
            }
        }
    }
}
