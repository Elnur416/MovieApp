//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.02.25.
//

import Foundation
import Alamofire

class NetworkManager {
    private let baseURL = AppFile.baseURL
    private let header: HTTPHeaders = [
        "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsIm5iZiI6MTY0ODYyMDAzNC4xNTgwMDAyLCJzdWIiOiI2MjQzZjIwMmM1MGFkMjAwNWNkZTk1ZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xs9Bib0qWPDMeB9YXyPkYa4CzmQ5W4-N6rgdaLRPlZc"
    ]
    
    func request<T: Codable>(endpoint: Endpoint,
                             model: T.Type,
                             endpoint2: Endpoint? = nil,
                             method: HTTPMethod = .get,
                             params: Parameters? = nil,
                             encodingType: EncodingType = .url,
                             completion: @escaping((T?, String?) -> Void)) {
        AF.request("\(baseURL)\(endpoint.rawValue)",
                   method: method,
                   parameters: params,
                   encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                   headers: header).responseDecodable(of: model.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}

