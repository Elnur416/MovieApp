//
//  CollectionViewModel.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import Foundation

class CollectionViewModel {
    let useCase: CollectionUseCase
    var data: Collection?
    var collectionID: Int?
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    init(useCase: CollectionUseCase, collectionID: Int) {
        self.collectionID = collectionID
        self.useCase = useCase
    }
    
    func getCollectionData() {
        useCase.getCollectionData(collectionID: collectionID ?? 0) { data, error in
            if let data {
                self.data = data
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
