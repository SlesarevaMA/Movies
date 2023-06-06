//
//  Request.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

struct MovieListRequest: Request {
    
    let movieListUrl = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=1"
    var urlRequest: URLRequest {
        guard let url = URL(string: movieListUrl) else {
            fatalError("Unable to create url")
        }
        
        return URLRequest(url: url)
    }
}
