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
    
//    MARK: Enter
    
    func enter(email: String,
               password: String,
               completion: @escaping(String?) -> Void) {
        if Auth.auth().currentUser == nil {
            signUp(email: email,
                       password: password,
                       completion: completion)
        } else {
            signIn(email: email,
                   password: password,
                   completion: completion)
        }
    }
    
//    MARK: - SignUp
    
    private func signUp(email: String,
                    password: String,
                    completion: @escaping(String?) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
                return
            } else if let result = result {
                UserDefaults.standard.set(result.user.uid, forKey: "userID")
                completion(nil)
            }
        }
    }
    
//    MARK: - SignIn
    
    private func signIn(email: String,
                password: String,
                completion: @escaping(String?) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
                return
            } else if let result = result {
                UserDefaults.standard.set(result.user.uid, forKey: "userID")
                completion(nil)
            }
        }
    }
    
//    MARK: - SignOut
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
