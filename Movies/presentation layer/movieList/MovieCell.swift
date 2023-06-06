//
//  MovieCell.swift
//  Movies
//
//  Created by Margarita Slesareva on 01.06.2023.
//

import SwiftUI

struct MovieCell: View {
    let film: MovieListItem
    
    var body: some View {
        HStack(spacing: .zero) {
            image
            
            movieDescription
        }
        .padding(.horizontal, 15)
    }
    
    private var image: some View {
        AsyncImage(url: URL(string: film.posterUrl)!) { phase in
            phase
                .image?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 40, height: 63)
        .cornerRadius(5)
    }
    
    private var movieDescription: some View {
        VStack(alignment: .leading) {
            Text(film.name)
                .font(.system(size: 16, weight: .medium))
            
            Text("\(film.genres) (\(film.year.description))")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.init(hex: 0x666666))
        }
        .padding(.leading, 15)
    }
}
