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
    
    init() {
        movieService = MovieServiceImpl()
    }
    
    func onAppear() {
        subscription = movieService
            .getMovie()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] movie in
                self?.movie = movie
            }
    }
}
