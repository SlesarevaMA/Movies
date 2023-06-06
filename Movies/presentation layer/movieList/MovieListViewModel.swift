//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Margarita Slesareva on 04.06.2023.
//

import Combine
import Foundation

final class MovieListViewModel: ObservableObject {
    @Published var movies = [MovieListItem]()
    
    private let movieService: MovieService
    
    private var subscription: AnyCancellable?
    
    init() {
        movieService = MovieServiceImpl()
    }
    
    func onAppear() {
        subscription = movieService
            .getMovieList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
    }
}
