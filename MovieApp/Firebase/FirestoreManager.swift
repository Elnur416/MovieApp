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
    
//    MARK: Save
    
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
    
//    MARK: - GetDocument
    
    func getDocument(completion: @escaping(([FirestoreModel]?, String?) -> Void)) {
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        db.collection(collection).getDocuments(completion: { data, error in
            if let error {
                completion(nil, error.localizedDescription)
            } else if let data = data {
                let movies: [FirestoreModel] = data.documents.compactMap { doc in
                    let data = doc.data()
                    return FirestoreModel(
                        posterPath: data["posterPath"] as? String,
                        releaseDate: data["releaseDate"] as? String,
                        title: data["title"] as? String,
                        id: data["id"] as? Int,
                        genres: data["genres"] as? [Int],
                        voteAverage: data["voteAverage"] as? Double
                    )
                }
                completion(movies, nil)
            }
        })
    }
    
//    MARK: - Delete
    
    func deleteDocument(movieID: Int) {
        guard let collection = UserDefaults.standard.value(forKey: "userID") as? String else { return }
        db.collection(collection).document("\(movieID)").delete()
    }
}
