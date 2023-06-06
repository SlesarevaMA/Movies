//
//  MoviListView.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI
import Combine

private enum Constants {
    static let title = "Фильмы"
    
    enum Cell {
        static let height: CGFloat = 93
        static let cornerRadius: CGFloat = 15
        static let color: Color = .white
        static let padding: EdgeInsets = .init(top: 6, leading: 16, bottom: 6, trailing: 16)
        static let shadowColor: Color = .init(hex: 0xbfbfbf)
        static let shadowRadius: CGFloat = 10
    }
}

struct MoviesListView: View {
    @StateObject var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.movies) { movie in
                MovieCell(movie: movie)
                    .background {
                        // Скрытие стрелки
                        NavigationLink(value: movie) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: Constants.Cell.cornerRadius)
                            .foregroundColor(Constants.Cell.color)
                            .padding(Constants.Cell.padding)
                            .shadow(color: Constants.Cell.shadowColor, radius: Constants.Cell.shadowRadius)
                    )
                    .frame(height: Constants.Cell.height)
            }
            .navigationDestination(for: MovieListItem.self) { movie in                
                MovieDetailView(kinopoiskId: movie.kinopoiskId)
            }
            .navigationTitle(Text(Constants.title))
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
