//
//  HeroesView.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 04/07/24.
//

import SwiftUI

struct HeroesView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: HeroListViewModel = HeroListViewModel()
    
    var body: some View {
        AsyncResultStateView(result: viewModel.result) { characters in
            List(characters) { hero in
                HeroItemView(hero: hero)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        router.navigateTo(.heroDetail(heroId: hero.id ?? 0))
                    }
            }
        }
        .task {
            await viewModel.fetchHeroes()
        }
        .navigationTitle("Heroes")
    }
}

struct HeroItemView: View {
    
    var hero: Hero
    
    private let cardHeight: CGFloat = 180
    
    var body: some View {
        AsyncImage(url: URL(string: hero.thumbnail?.imagePath ?? "")) { photo in
            photo
                .resizable()
                .frame(height: cardHeight)
                .cornerRadius(20)
                .overlay(
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.clear, .clear, .clear, .black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                        .cornerRadius(20)
                        
                        VStack {
                            Text(hero.name ?? "")
                                .foregroundColor(.white)
                                .bold()
                                .lineLimit(1)
                                .padding(.top, 4)
                                .padding(.horizontal, 10)
                            
                            Spacer()
                        }
                    }
                )
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: cardHeight)
                    .foregroundColor(.gray)
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    HeroesView(viewModel: HeroListViewModel(mockable: true))
}
