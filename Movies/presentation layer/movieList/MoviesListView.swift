//
//  MoviListView.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI
import Combine

private enum Metrics {
    
}

struct MoviesListView: View {
    @StateObject var viewModel = MovieListViewModel()
//    @State private var selectedMovie: Movie?
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                MovieCell(film: movie)
                    .background {
                        // Скрываем стрелку
                        NavigationLink(value: movie) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .shadow(color: .init(hex: 0xbfbfbf), radius: 10)

                    )
                .frame(height: 93)
            }
            .navigationDestination(for: MovieListItem.self) { movie in                
                MovieDetailView(kinopoiskId: movie.kinopoiskId)
            }
            .listStyle(PlainListStyle())
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

struct MoviesList_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
