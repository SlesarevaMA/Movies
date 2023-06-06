//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Margarita Slesareva on 04.06.2023.
//

import Combine
import Foundation

struct Genre: Decodable {
    let genre: String
}

struct FilmAPIEntity: Decodable {
    let nameRu: String
    let genres: [Genre]
    let year: String
    let posterUrlPreview: String
}

struct MoiveResponse: Decodable {
    let pagesCount: Int
    let films: [FilmAPIEntity]
}

final class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    private let reqeustFactory: RequestFactory
    private let networkService: NetworkService
    
    private var subscription: AnyCancellable?
    
    init(reqeustFactory: RequestFactory = RequestFactoryImpl()) {
        self.reqeustFactory = reqeustFactory
        networkService = NetworkServiceImpl(
            decoder: JSONDecoder(),
            requestManager: RequestManagerImpl()
        )
    }
    
    func onAppear() {
        guard let movieListRequest = reqeustFactory.movieListRequest(page: 1) else {
            return
        }
        
        let publisher: AnyPublisher<MoiveResponse, Error> = networkService
            .requestData(request: movieListRequest)
        
        subscription = publisher
            .map(mapResponse)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
    }
    
    private func mapResponse(_ response: MoiveResponse) -> [Movie] {
        return response.films.map { film in
            let genres = film.genres.reduce("", { perviousResult, nextValue in
                if perviousResult.isEmpty {
                    return nextValue.genre
                }
                
                return perviousResult + ", " + nextValue.genre
            })
            
            return Movie(
                kinopoiskId: 0,
                name: film.nameRu,
                description: "",
                countries: "",
                genres: genres,
                year: Int(film.year) ?? 0,
                posterUrl: film.posterUrlPreview
            )
        }
    }
}
