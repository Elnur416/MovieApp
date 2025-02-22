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
        let genresArray = model.genres?.compactMap { $0.name } ?? []
        let data: [String: Any] = ["movieID": model.id ?? 0,
                                   "poster": model.posterPath ?? "",
                                   "title": model.title ?? "",
                                   "imdb": model.voteAverage ?? "",
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
}
