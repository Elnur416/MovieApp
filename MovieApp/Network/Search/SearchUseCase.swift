//
//  SearchUseCase.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 08.02.25.
//

import Foundation

protocol SearchUseCase {
    func getSearchResults(query: String, completion: @escaping ((Movie?, String?) -> Void))
}
