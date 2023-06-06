//
//  MovieListItem.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import Foundation

struct MovieListItem: Identifiable, Hashable {
    let id = UUID()
    
    let kinopoiskId: Int
    let name: String
    let genre: String
    let year: Int
    let posterUrl: URL
}
