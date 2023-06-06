//
//  Request.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation

protocol RequestFactory {
    func movieListRequest(page: Int) -> URLRequest?
}

final class RequestFactoryImpl: RequestFactory {
    
    private let apiUrl = "https://kinopoiskapiunofficial.tech/api/"
    private let headers = [
        "X-API-KEY": "2139142e-dcb0-49f5-8f46-073bcf20dff7",
        "Content-Type": "application/json"
    ]
    
    func movieListRequest(page: Int) -> URLRequest? {
        let movieListUrl = apiUrl + "v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=\(page)"
        
        guard let url = URL(string: movieListUrl) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
