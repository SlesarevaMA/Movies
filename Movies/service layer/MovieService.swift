//
//  MovieService.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation
import Combine

protocol MovieService {
    func getMovieList() -> AnyPublisher<[MovieListItem], Error>
    func getMovie() -> AnyPublisher<Movie, Error>
}

final class MovieServiceImpl: MovieService {
    
    private let decoder: JSONDecoder
    private let requestManager: RequestManager
    private let reqeustFactory: RequestFactory
    
    init(
        decoder: JSONDecoder = JSONDecoder(),
        requestManager: RequestManager = RequestManagerImpl(),
        requestFactory: RequestFactory = RequestFactoryImpl()
    ) {
        self.decoder = decoder
        self.requestManager = requestManager
        self.reqeustFactory = requestFactory
    }
    
    func getMovieList() -> AnyPublisher<[MovieListItem], Error> {
        guard let movieListRequest = reqeustFactory.movieListRequest(page: 1) else {
            fatalError()
        }

        let publisher: AnyPublisher<MoiveListResponse, Error> = requestData(request: movieListRequest)
        
        return publisher
            .map(mapMovieListResponse)
            .eraseToAnyPublisher()
    }
    
    func getMovie() -> AnyPublisher<Movie, Error> {
        guard let movieRequest = reqeustFactory.movieRequest(movie: 301) else {
            fatalError()
        }

        let publisher: AnyPublisher<MoiveResponse, Error> = requestData(request: movieRequest)
        
        return publisher
            .map(mapMovieResponse)
            .eraseToAnyPublisher()
    }
            
    private func requestData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        return requestManager.request(request: request)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    private func mapMovieListResponse(_ response: MoiveListResponse) -> [MovieListItem] {
        return response.films.map { movie in
            let genres = mapGenres(genres: movie.genres)
                        
            return MovieListItem(
                kinopoiskId: movie.filmId,
                name: movie.nameRu,
                genres: genres,
                year: Int(movie.year) ?? 0,
                posterUrl: movie.posterUrlPreview
            )
        }
    }
    
    private func mapMovieResponse(_ response: MoiveResponse) -> Movie {
        let genres = mapGenres(genres: response.genres)
        let countries = mapContries(contries: response.countries)
        
        return Movie(
            kinopoiskId: response.kinopoiskId,
            name: response.nameRu,
            description: response.description,
            countries: countries,
            genres: genres,
            year: response.year,
            posterUrl: response.posterUrlPreview
        )
    }
    
    private func mapGenres(genres: [Genre]) -> String {
        genres.reduce("", { perviousResult, nextValue in
            if perviousResult.isEmpty {
                return nextValue.genre
            }
            
            return perviousResult + ", " + nextValue.genre
        })
    }
    
    private func mapContries<T: Decodable>(contries: [T]) -> String {
        contries.reduce("", { perviousResult, nextValue in
            if perviousResult.isEmpty {
                return "\(nextValue)"
            }
            
            return perviousResult + ", " + "\(nextValue)"
        })
    }
}
