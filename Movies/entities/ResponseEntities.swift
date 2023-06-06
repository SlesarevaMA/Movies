//
//  ResponseEntities.swift
//  Movies
//
//  Created by Margarita Slesareva on 05.06.2023.
//

import Foundation

struct Country: Decodable, CustomStringConvertible {
    let country: String
    
    var description: String {
        return country
    }
}

struct Genre: Decodable, CustomStringConvertible {
    let genre: String
    
    var description: String {
        return genre
    }
}

struct FilmListAPIEntity: Decodable {
    let filmId: Int
    let nameRu: String
    let genres: [Genre]
    let year: String
    let posterUrlPreview: String
}

struct MoiveListResponse: Decodable {
    let pagesCount: Int
    let films: [FilmListAPIEntity]
}

struct MoiveResponse: Decodable {
    let kinopoiskId: Int
    let nameRu: String
    let description: String
    let countries: [Country]
    let genres: [Genre]
    let year: Int
    let posterUrlPreview: String
}
