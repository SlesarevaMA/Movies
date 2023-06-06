//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Margarita Slesareva on 05.06.2023.
//

import Combine
import Foundation

final class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    
    private let movieService: MovieService
    
    private var subscription: AnyCancellable?
    private var movieId: Int?
    
    init(movieService: MovieService = MovieServiceImpl()) {
        self.movieService = movieService
    }
    
    func setMovieId(_ movieId: Int) {
        self.movieId = movieId
    }
    
    func onAppear() {
        guard let movieId else {
            return
        }
        
        subscription = movieService
            .getMovie(for: movieId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] movie in
                self?.movie = movie
            }
    }
}
