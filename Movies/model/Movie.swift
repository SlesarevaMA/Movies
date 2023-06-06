//
//  Movie.swift
//  Movies
//
//  Created by Margarita Slesareva on 05.06.2023.
//

struct Movie: Hashable {
    let kinopoiskId: Int
    let name: String
    let description: String
    let countries: String
    let genres: String
    let year: Int
    let posterUrl: String
}
