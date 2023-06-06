//
//  Decoder.swift
//  Movies
//
//  Created by Margarita Slesareva on 02.06.2023.
//

import Foundation

protocol Decoder {
    func decode<T: Decodable>(type: T.Type, from data: Data) throws -> T
}

final class DecoderImpl: Decoder {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func decode<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}
