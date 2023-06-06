//
//  RequestManager.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation
import Combine

protocol RequestManager {
    func request(request: URLRequest) -> AnyPublisher<Data, Error>
}

final class RequestManagerImpl: RequestManager {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(request: URLRequest) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                    throw NetworkError.invalidResponse(statusCode)
                }

                return data
            }
            .eraseToAnyPublisher()
    }
}
