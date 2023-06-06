//
//  MoviListView.swift
//  Films
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI
import Combine

final class MovieListViewModel: ObservableObject {
    
}

struct MovieListView: View {
    var films: [Film]
    
    var body: some View {
        NavigationView {
            List(films) { film in
                FilmCell(film: film)
            }
        }
    }
}

struct FilmsList_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(films: [
            Film(
                kinopoiskId: 301,
                nameRu: "Матрица",
                description: "Жизнь Томаса Андерсона разделена на две части:",
                countries: "США",
                genres: "фантастика",
                year: 1999,
                posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/301.jpg"
            )
        ])
    }
}
