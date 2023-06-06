//
//  RequestManager.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation

protocol RequestManager {
    func request(request: Request, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class RequestManagerImpl: RequestManager {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(request: Request, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let dataTask = session.dataTask(with: request.urlRequest) { data, response, error in
            if let error {
                completion(.failure(.other(error)))
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                completion(.failure(.invalidResponse(statusCode)))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }
        
        dataTask.resume()
    }
}
