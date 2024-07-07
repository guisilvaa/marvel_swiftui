//
//  HeroDetailView.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 05/07/24.
//

import SwiftUI

struct HeroDetailView: View {
    @ObservedObject var viewModel: HeroDetailViewModel
    
    private let headerImageHeight: CGFloat = 250
    
    private var character: Hero?
    
    init(heroId: Int) {
        viewModel = HeroDetailViewModel(heroId: heroId)
    }
    
    var body: some View {
        AsyncResultStateView(result: viewModel.result) { character in
            ScrollView {
                VStack() {
                    headerImageView(imageUrl: character?.thumbnail?.imagePath ?? "")
                    characterDescriptionView(character)
                    comicsView(comicsAvailable: character?.comics?.available ?? 0)
                }
            }
        }
        .task {
            await viewModel.fetchHeroDetail()
        }
        .navigationTitle("Detail")
    }
    
    private func headerImageView(imageUrl: String) -> some View {
        AsyncImage(url: URL(string: imageUrl)) { photo in
            photo
                .resizable()
                .frame(height: headerImageHeight)
                .cornerRadius(10)
        } placeholder: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: headerImageHeight)
                    .foregroundColor(.gray)
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding()
                    .foregroundColor(.black)
            }
        }
    }
    
    private func characterDescriptionView(_ character: Hero?) -> some View {
        LazyVStack() {
            Text(character?.name ?? "")
                .font(.system(.largeTitle, weight: .bold))
                .padding([.vertical], 10)
            
            Text(character?.description ?? "")
                .font(.body)
                .padding([.bottom], 10)
        }
        .padding(.horizontal, 20)
    }
    
    private func comicsView(comicsAvailable: Int) -> some View {
        VStack() {
            Text("Comics (\(comicsAvailable))")
                .font(.system(.title2, weight: .bold))
                .padding([.bottom], 5)
            
            AsyncResultStateView(result: viewModel.comicsResult) { comics in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(comics) { item in
                            comicItemView(model: item)
                        }
                    }
                }
            }
        }
    }
    
    private func comicItemView(model: ComicModel) -> some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: model.thumbnail?.imagePath ?? "")) { photo in
                photo
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fit)
                    .cornerRadius(15)
                    .frame(height: 200)
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: headerImageHeight)
                        .foregroundColor(.gray)
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding()
                        .foregroundColor(.black)
                }
            }
            
            Text(model.title ?? "")
                .multilineTextAlignment(.center)
                .font(.headline)
                .frame(width: 150)
        }
        .padding([.leading], 10)
    }
}

#Preview {
    let viewModel = HeroDetailViewModel(heroId: 1, mockable: true)
    var view = HeroDetailView(heroId: 1)
    view.viewModel = viewModel
    return view
}
