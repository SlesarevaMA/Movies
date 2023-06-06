//
//  MovieDetailView.swift
//  Movies
//
//  Created by Margarita Slesareva on 31.05.2023.
//

import SwiftUI

private enum Constants {
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

    enum DesriptoinTitles {
        static let genres = AttributedString(unicodeScalarLiteral: "Жанры: ").settingAttributes(style)
        static let countries = AttributedString(unicodeScalarLiteral: "Страны: ").settingAttributes(style)
        static let year = AttributedString(unicodeScalarLiteral: "Год: ").settingAttributes(style)
        private static let style: AttributeContainer = AttributeContainer.font(.system(size: 16, weight: .bold))
    }
}

struct MovieDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let kinopoiskId: Int
    
    @StateObject var viewModel = MovieDetailViewModel()
        
    var body: some View {
        VStack.zeroSpacing {
            image
                .frame(maxHeight: Constants.imageMaxHeight)
                        
            descriptions
                .padding(.horizontal, Constants.horizontalDescriptionSpacing)
            
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
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Constants.BackButton.name)
                .font(Constants.BackButton.font)
                .foregroundColor(Constants.BackButton.color)
        })
    }
    
    private var descriptions: some View {
        VStack.zeroSpacing {
            if let movie = viewModel.movie {
                Text(movie.name)
                    .font(Constants.titleFont)
                    .padding(.top, Constants.topDescriptionVerticalSpacing)
                
                Text(movie.description)
                    .font(Constants.descriptionFont)
                    .foregroundColor(Constants.descriptionColor)
                    .padding(.vertical, Constants.verticalSpacing)
                
                Text("\(Constants.DesriptoinTitles.genres)\(movie.genres)")
                    .font(Constants.descriptionFont)
                    .foregroundColor(Constants.descriptionColor)
                
                Text("\(Constants.DesriptoinTitles.countries)\(movie.countries)")
                    .font(Constants.descriptionFont)
                    .foregroundColor(Constants.descriptionColor)
                    .padding(.top, Constants.topSpacing)
                
                Text("\(Constants.DesriptoinTitles.year)\(movie.year.description)")
                    .font(Constants.descriptionFont)
                    .foregroundColor(Constants.descriptionColor)
                    .padding(.top, Constants.topSpacing)
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
