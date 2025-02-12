//
//  CollectionViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import Foundation

class CollectionViewModel {
    let manager = CollectionManager()
    var data: Collection?
    var collectionID: Int?
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func getCollectionData() {
        manager.getCollectionData(collectionID: collectionID ?? 0) { data, error in
            if let data {
                self.data = data
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
