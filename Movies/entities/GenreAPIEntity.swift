//
//  GenreAPIEntity.swift
//  Movies
//
//  Created by Margarita Slesareva on 06.06.2023.
//

struct GenreAPIEntity: Decodable, CustomStringConvertible {
    let genre: String
    
    var description: String {
        return genre
    }
}
