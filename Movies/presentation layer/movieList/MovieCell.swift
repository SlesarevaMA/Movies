//
//  MovieCell.swift
//  Movies
//
//  Created by Margarita Slesareva on 01.06.2023.
//

import SwiftUI

struct MovieCell: View {
    let film: Movie
    
    var body: some View {
        let filmDetail = FilmDetail(
            url: URL(string: film.posterUrl)!,
            name: film.nameRu,
            genre: film.genres,
            description: film.description,
            country: film.countries,
            year: film.year
        )
        
        NavigationLink(destination: FilmDetailView(model: filmDetail)) {
            AsyncImage(url: URL(string: film.posterUrl)!) { phase in
                phase
                    .image?
                    .resizable()
                    .aspectRatio(0.6, contentMode: .fill)
            }
                .frame(width: 40, height: 60)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                Text(film.nameRu)
                    .font(.system(size: 16, weight: .medium))
                
                Text("\(film.genres) (\(film.year.description))")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.init(hex: 0x666666))
            }
        }
    }
}
