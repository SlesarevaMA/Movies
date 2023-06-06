//
//  NetworkService.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation
import Combine

protocol NetworkService {
    func requestData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error>
}

final class NetworkServiceImpl: NetworkService {
    
    private let decoder: JSONDecoder
    private let requestManager: RequestManager

    init(decoder: JSONDecoder, requestManager: RequestManager) {
        self.decoder = decoder
        self.requestManager = requestManager
    }
    
    func requestData<T: Decodable>(request: URLRequest) -> AnyPublisher<T, Error> {
        return requestManager.request(request: request)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
