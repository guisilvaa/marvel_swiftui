//
//  HeroesView.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 04/07/24.
//

import SwiftUI

struct HeroesView: View {
    
    @ObservedObject var viewModel: HeroListViewModel = HeroListViewModel()
    
    var body: some View {
        List(viewModel.heroes, id: \.id) { hero in
            HeroItemView(hero: hero)
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
    HeroesView()
}
