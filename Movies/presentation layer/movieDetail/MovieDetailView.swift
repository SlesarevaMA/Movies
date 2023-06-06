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
    let url: URL
    let name: String
    let genres: String
    let description: String
    let country: String
    let year: Int
}

struct MovieDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let model: MovieDetail
        
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
            Text(model.name)
                .font(Metrics.titleFont)
                .padding(.top, 20)
            
            Text(model.description)
                .font(Metrics.descriptionFont)
                .foregroundColor(Metrics.descriptionColor)
                .padding(.vertical, 16)
            
            Text("Жанры: \(model.genre)")
                .font(Metrics.descriptionFont)
                .foregroundColor(Metrics.descriptionColor)
            
            Text("Страны: \(model.country)")
                .font(Metrics.descriptionFont)
                .foregroundColor(Metrics.descriptionColor)
                .padding(.top, 8.0)
            
            Text("Год: \(model.year.description)")
                .font(Metrics.descriptionFont)
                .foregroundColor(Metrics.descriptionColor)
                .padding(.top, 8.0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var image: some View {
        AsyncImage(url: model.url) { phase in
            phase
                .image?
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(model: MovieDetail(
            url: URL(string: "https://kinopoiskapiunofficial.tech/images/posters/kp/840152.jpg")!,
            name: "Изгой-один: Звёздные войны",
            genres: "Жанры: фантастика, приключения",
            description: "Сопротивление собирает отряд для выполнения особой миссии - надо выкрасть чертежи самого совершенного и мертоносного оружия Империи. Не всем суждено вернуться домой, но герои готовы к этому, ведь на кону судьба Галактики",
            country: "США",
            year: 2022
        ))
    }
}
