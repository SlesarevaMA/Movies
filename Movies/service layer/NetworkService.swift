//
//  NetworkService.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation

protocol NetworkService {
    func requestData<T: Decodable>(request: Request, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkServiceImpl: NetworkService {
    
    private let decoder: Decoder
    private let requestManager: RequestManager

    init(decoder: Decoder, requestManager: RequestManager) {
        self.decoder = decoder
        self.requestManager = requestManager
    }
    
    func requestData<T: Decodable>(request: Request, completion: @escaping (Result<T, NetworkError>) -> Void) {
        requestManager.request(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedValue = try self.decoder.decode(type: T.self, from: data)
                    completion(.success(decodedValue))
                } catch {
                    completion(.failure(.decode(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
