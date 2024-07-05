//
//  HeroDetailView.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 05/07/24.
//

import SwiftUI

struct HeroDetailView: View {
    @ObservedObject var viewModel: HeroDetailViewModel
    
    init(heroId: Int) {
        viewModel = HeroDetailViewModel(heroId: heroId)
    }
    
    var body: some View {
        Text(viewModel.hero?.name ?? "")
        .task {
            await viewModel.fetchHeroDetail()
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    let viewModel = HeroDetailViewModel(heroId: 1, mockable: true)
    var view = HeroDetailView(heroId: 1)
    view.viewModel = viewModel
    return view
}
