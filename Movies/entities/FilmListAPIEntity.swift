//
//  FilmListAPIEntity.swift
//  Movies
//
//  Created by Margarita Slesareva on 06.06.2023.
//

struct FilmListAPIEntity: Decodable {
    let filmId: Int
    let nameRu: String
    let genres: [GenreAPIEntity]
    let year: String
    let posterUrlPreview: String
}
