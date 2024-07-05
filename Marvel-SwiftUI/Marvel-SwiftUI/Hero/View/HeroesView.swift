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
    
    @State private var heroSelected: Hero?
    
    var body: some View {
        List(viewModel.heroes,
             selection: $heroSelected) { hero in
            HeroItemView(hero: hero)
                .contentShape(Rectangle())
                         .onTapGesture {
                             router.navigateTo(.heroDetail(heroId: hero.id ?? 0))
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
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            
            Text(hero.name ?? "")
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HeroesView(viewModel: HeroListViewModel(mockable: true))
}
