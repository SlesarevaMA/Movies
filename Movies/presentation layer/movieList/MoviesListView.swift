//
//  MoviListView.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI
import Combine

// 1 Network Stack

final class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    init(films: [Movie] = [Movie]()) {
        self.movies = [
            Movie(
                kinopoiskId: 301,
                nameRu: "Матрица",
                description: "Жизнь Томаса Андерсона разделена на две части:",
                countries: "США",
                genres: "фантастика",
                year: 1999,
                posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/301.jpg"
            )
        ]
    }
}

struct MoviesListView: View {
    @StateObject var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { film in
                MovieCell(film: film)
            }
        }
    }
}

//struct MoviesList_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesListView(films: [
//            Movie(
//                kinopoiskId: 301,
//                nameRu: "Матрица",
//                description: "Жизнь Томаса Андерсона разделена на две части:",
//                countries: "США",
//                genres: "фантастика",
//                year: 1999,
//                posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/301.jpg"
//            )
//        ])
//    }
//}
