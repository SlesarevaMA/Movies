//
//  MovieDetailView.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI

private enum Metrics {
    static let titleFont: Font = .system(size: 16, weight: .bold)
    static let descriptionFont: Font = .system(size: 14)
    static let descriptionColor: Color = .init(hex: 0x666666)
    
    static let topDescriptionVerticalSpacing: CGFloat = 20
    static let horizontalDescriptionSpacing: CGFloat = 30
    static let verticalSpacing: CGFloat = 16
    static let topSpacing: CGFloat = 8
    
    static let imageMaxHeight: CGFloat = 600
    
    enum BackButton {
        static let name = "arrow.left"
        static let font: Font = .system(size: 16, weight: .bold)
        static let color: Color = .init(hex: 0x4557A2)
    }
    
    static let style: AttributeContainer = AttributeContainer.font(.system(size: 16, weight: .bold))

    enum desriptoinTitles {
        static let genres = AttributedString(unicodeScalarLiteral: "Жанры: ").settingAttributes(style)
        static let countries = AttributedString(unicodeScalarLiteral: "Страны: ").settingAttributes(style)
        static let year = AttributedString(unicodeScalarLiteral: "Год: ").settingAttributes(style)
    }
}

struct MovieDetail {
    let id: Int
    let url: URL
    let name: String
    let genres: String
    let description: String
    let countries: String
    let year: Int
}

struct MovieDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let kinopoiskId: Int
    
    @StateObject var viewModel = MovieDetailViewModel()
        
    var body: some View {
        VStack.zeroSpacing {
            image
                .frame(maxHeight: Metrics.imageMaxHeight)
                        
            descriptions
                .padding(.horizontal, Metrics.horizontalDescriptionSpacing)
            
            Spacer(minLength: 0)
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: backButton)
        .onAppear {
            viewModel.setMovieId(kinopoiskId)
            viewModel.onAppear()
        }
    }
    
    func setMovieId(_ movieId: Int) {
        viewModel.setMovieId(movieId)
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Metrics.BackButton.name)
                .font(Metrics.BackButton.font)
                .foregroundColor(Metrics.BackButton.color)
        })
    }
    
    private var descriptions: some View {
        VStack.zeroSpacing {
            
            if let movie = viewModel.movie {
                Text(movie.name)
                    .font(Metrics.titleFont)
                    .padding(.top, Metrics.topDescriptionVerticalSpacing)
                
                Text(movie.description)
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                    .padding(.vertical, Metrics.verticalSpacing)
                
                Text("\(Metrics.desriptoinTitles.genres)\(movie.genres)")
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                
                Text("\(Metrics.desriptoinTitles.countries)\(movie.countries)")
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                    .padding(.top, Metrics.topSpacing)
                
                Text("\(Metrics.desriptoinTitles.year)\(movie.year.description)")
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                    .padding(.top, Metrics.topSpacing)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder private var image: some View {
        if let movie = viewModel.movie {
            AsyncImage(url: movie.posterUrl) { phase in
                phase
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
