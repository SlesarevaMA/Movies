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
    func getMovie(for movieId: Int) -> AnyPublisher<Movie, Error>
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
            // Just
            fatalError()
        }

        let publisher: AnyPublisher<MoiveListResponse, Error> = requestData(request: movieListRequest)
        
        return publisher
            .map(mapMovieListResponse)
            .eraseToAnyPublisher()
    }
    
    func getMovie(for movieId: Int) -> AnyPublisher<Movie, Error> {
        guard let movieRequest = reqeustFactory.movieRequest(for: movieId) else {
            // Just
            fatalError()
        }

        let publisher: AnyPublisher<MoiveResponse, Error> = requestData(request: movieRequest)
        
        return publisher
            .compactMap(mapMovieResponse)
            .eraseToAnyPublisher()
    }
            
    private func requestData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        return requestManager.request(request: request)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    private func mapMovieListResponse(_ response: MoiveListResponse) -> [MovieListItem] {
        return response.films.compactMap { movie in
            guard let posterUrl = URL(string: movie.posterUrlPreview) else {
                return nil
            }
            
            let genre = movie.genres.first?.description ?? ""

            return MovieListItem(
                kinopoiskId: movie.filmId,
                name: movie.nameRu,
                genre: genre,
                year: Int(movie.year) ?? 0,
                posterUrl: posterUrl
            )
        }
    }
    
    private func mapMovieResponse(_ response: MoiveResponse) -> Movie? {
        guard let posterUrl = URL(string: response.posterUrlPreview) else {
            return nil
        }
        
        let genres = mapEntities(entities: response.genres)
        let countries = mapEntities(entities: response.countries)
        
        return Movie(
            kinopoiskId: response.kinopoiskId,
            name: response.nameRu,
            description: response.description,
            countries: countries,
            genres: genres,
            year: response.year,
            posterUrl: posterUrl
        )
    }
        
    private func mapEntities<T: CustomStringConvertible>(entities: [T]) -> String {
        entities.reduce("", { perviousResult, nextValue in
            if perviousResult.isEmpty {
                return "\(nextValue.description)"
            }
            
            return perviousResult + ", " + "\(nextValue.description)"
        })
    }
}
