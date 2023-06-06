//
//  MovieDetailView.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI

private enum Metrics {
    static let titleFont: Font = .system(size: 20, weight: .semibold)
    static let descriptionFont: Font = .system(size: 14)
    static let descriptionColor: Color = .init(hex: 0x666666)
    
    static let topDescriptionVerticalSpacing: CGFloat = 20
    static let bottomDescriptionVerticalSpacing: CGFloat = 24
    static let horizontalDescriptionSpacing: CGFloat = 30
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
                .frame(maxHeight: 600)
                        
            descriptions
                .padding(.horizontal, 30)
            
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
            Image(systemName: "arrow.left")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color(hex: 0x4557A2))
        })
    }
    
    private var titleString: AttributedString {
        let result = AttributedString()
        let style = AttributeContainer.font(.system(size: 16, weight: .bold))
        return result.settingAttributes(style)
    }
    
    private var descriptions: some View {
        VStack.zeroSpacing {
            if let movie = viewModel.movie {
                Text(movie.name)
                    .font(Metrics.titleFont)
                    .padding(.top, 20)
                
                Text(movie.description)
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                    .padding(.vertical, 16)
                
                Text("Жанры: \(movie.genres)")
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                
                Text("Страны: \(movie.countries)")
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                    .padding(.top, 8.0)
                
                Text("Год: \(movie.year.description)")
                    .font(Metrics.descriptionFont)
                    .foregroundColor(Metrics.descriptionColor)
                    .padding(.top, 8.0)
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
