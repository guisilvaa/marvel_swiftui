//
//  HeroesView.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 04/07/24.
//

import SwiftUI

struct CharactersListView: View {
    
    @EnvironmentObject var router: Router
    
    @ObservedObject var viewModel: CharactersListViewModel = CharactersListViewModel()
    
    var body: some View {
        AsyncResultStateView(result: viewModel.result) { characters in
            List(characters) { character in
                CharacterItemView(character: character)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        router.navigateTo(.characterDetail(characterId: character.id ?? 0))
                    }
                    .onAppear {
                        Task {
                            await viewModel.loadMoreCharacters(currentCharacter: character)
                        }
                    }
            }
        }
        .task {
            await viewModel.fetchCharacters()
        }
        .navigationTitle("Characters")
    }
}

struct CharacterItemView: View {
    
    var character: CharacterModel
    
    private let cardHeight: CGFloat = 180
    
    var body: some View {
        AsyncImage(url: URL(string: character.thumbnail?.imagePath ?? "")) { photo in
            photo
                .resizable()
                .frame(height: cardHeight)
                .cornerRadius(20)
                .overlay(
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.clear, .clear, .clear, .black.opacity(0.8)]), startPoint: .bottom, endPoint: .top)
                        .cornerRadius(20)
                        
                        VStack {
                            Text(character.name ?? "")
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
    CharactersListView(viewModel: CharactersListViewModel(mockable: true))
}
