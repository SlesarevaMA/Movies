//
//  MoiveResponse.swift
//  Movies
//
//  Created by Margarita Slesareva on 05.06.2023.
//

struct MoiveResponse: Decodable {
    let kinopoiskId: Int
    let nameRu: String
    let description: String
    let countries: [CountryAPIEntity]
    let genres: [GenreAPIEntity]
    let year: Int
    let posterUrlPreview: String
}
