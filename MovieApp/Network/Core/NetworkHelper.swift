//
//  AppFile.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 01.02.25.
//

import Foundation
import Alamofire

enum EncodingType {
    case url
    case json
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    private let baseURL = "https://api.themoviedb.org/3/"
    let imageBaseURL = "https://image.tmdb.org/t/p/original"
    let youtubeApiKey = "AIzaSyDOW42b6w7pP2eOxBpEZjbbK9jWcvR9lcA"
    private let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    let header: HTTPHeaders = [
        "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsIm5iZiI6MTY0ODYyMDAzNC4xNTgwMDAyLCJzdWIiOiI2MjQzZjIwMmM1MGFkMjAwNWNkZTk1ZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xs9Bib0qWPDMeB9YXyPkYa4CzmQ5W4-N6rgdaLRPlZc"
    ]
    
    func configureURL(endpoint: String) -> String {
        return baseURL + endpoint
    }
    
    func getMovieTrailer(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(youtubeBaseURL)q=\(query)=\(youtubeApiKey)") else { return }
    }
}
