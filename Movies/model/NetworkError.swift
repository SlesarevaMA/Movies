//
//  NetworkError.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

enum NetworkError: Error {
    case noData
    case invalidResponse(Int)
    case other(Error)
    case decode(Error)
}
