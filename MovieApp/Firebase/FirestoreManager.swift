//
//  FirestoreManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 22.02.25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func saveMovie(model: MovieDetail, completion: @escaping((String?) -> Void)) {
        let genresArray = model.genres?.compactMap { $0.id } ?? []
        let data: [String: Any] = ["id": model.id ?? 0,
                                   "posterPath": model.posterPath ?? "",
                                   "title": model.title ?? "",
                                   "voteAverage": model.voteAverage ?? "",
                                   "genres": genresArray,
                                   "releaseDate": model.releaseDate ?? ""]
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        
        db.collection(collection).document("\(model.id ?? 0)").setData(data) { error in
            if let error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
    
    func getMovies(count: Int, completion: @escaping(([String: Any]?, String?) -> Void)) {
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        db.collection(collection).getDocuments { snapshot, error in
            if let snapshot {
                guard let data = snapshot.documents[count - 1].data() as? [String: Any] else { return }
                completion(data, nil)
            } else if let error {
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getDocument(completion: @escaping(([String: Any]?, String?) -> Void)) {
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        db.collection(collection).getDocuments { snapshot, error in
            if let snapshot {
                let count = snapshot.documents.count
                if count > 0 {
                    for index in 1...count {
                        self.getMovies(count: index) { data, error in
                            if let data {
                                completion(data, nil)
                            } else if let error {
                                completion(nil, error)
                            }
                        }
                    }
                } else {
                    return
                }
            } else if let error {
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func deleteDocument(movieID: Int) {
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        db.collection(collection).document("\(movieID)").delete()
    }
}

