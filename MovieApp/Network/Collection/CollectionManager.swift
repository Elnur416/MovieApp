//
//  CollectionManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import Foundation

class CollectionManager: CollectionUseCase {
    let manager = NetworkManager()
    
    func getCollectionData(collectionID: Int, completion: @escaping ((Collection?, String?) -> Void)) {
        let path = CollectionEndpoint.collection(id: collectionID).path
        manager.request(path: path,
                        model: Collection.self,
                        completion: completion)
    }
}
