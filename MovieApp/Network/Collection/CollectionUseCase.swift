//
//  CollectionUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 12.02.25.
//

import Foundation

protocol CollectionUseCase {
    func getCollectionData(collectionID: Int, completion: @escaping((Collection?, String?) -> Void))
}
