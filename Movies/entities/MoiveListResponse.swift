//
//  MoiveListResponse.swift
//  Movies
//
//  Created by Margarita Slesareva on 06.06.2023.
//

struct MoiveListResponse: Decodable {
    let pagesCount: Int
    let films: [FilmListAPIEntity]
}
