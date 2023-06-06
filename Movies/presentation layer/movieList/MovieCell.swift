//
//  MovieCell.swift
//  Movies
//
//  Created by Margarita Slesareva on 01.06.2023.
//

import SwiftUI

private enum Metrics {
    static let horizontalPadding: CGFloat = 15
    
    static let nameFont: Font = .system(size: 16, weight: .medium)
    static let descriptionFont: Font = .system(size: 14, weight: .medium)
    static let descriptionColor: Color = .init(hex: 0x666666)
        
    enum Image {
        static let width: CGFloat = 40
        static let height: CGFloat = 63
        static let cornerRadius: CGFloat = 5
    }
}

struct MovieCell: View {
    let movie: MovieListItem
    
    var body: some View {
        HStack(spacing: .zero) {
            image
            
            movieDescription
        }
        .padding(.horizontal, Metrics.horizontalPadding)
    }
    
    private var image: some View {
        AsyncImage(url: movie.posterUrl) { phase in
            phase
                .image?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: Metrics.Image.width, height: Metrics.Image.height)
        .cornerRadius(Metrics.Image.cornerRadius)
    }
    
    private var movieDescription: some View {
        VStack(alignment: .leading) {
            Text(movie.name)
                .font(Metrics.nameFont)
            
            Text("\(movie.genre) (\(movie.year.description))")
                .font(Metrics.descriptionFont)
                .foregroundColor(Metrics.descriptionColor)
        }
        .padding(.leading, Metrics.horizontalPadding)
    }
}
