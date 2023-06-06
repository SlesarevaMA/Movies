//
//  Movie.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI

struct Movie: Identifiable, Decodable {
    var id = UUID()
    
    let kinopoiskId: Int
    let nameRu: String
    let description: String
    let countries: String
    let genres: String
    let year: Int
    let posterUrl: String
}
