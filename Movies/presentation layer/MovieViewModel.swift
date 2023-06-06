//
//  MovieViewModel.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation

final class MovieViewModel: ObservableObject {
    var movies = [Movie]()
    
    let networkService: NetworkService
    
    private let movieListRequest = MovieListRequest()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadMovies() {
        networkService.requestData(request: movieListRequest) { (result: (Result<[Movie], NetworkError>)) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
}
