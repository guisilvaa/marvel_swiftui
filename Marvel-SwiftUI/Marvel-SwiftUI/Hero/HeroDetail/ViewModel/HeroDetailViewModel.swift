//
//  HeroDetailViewModel.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 05/07/24.
//

import Foundation
import SwiftUI

@MainActor
final class HeroDetailViewModel: ObservableObject {
    @Published var hero: Hero?
    @Published var error: Error?
    
    private var service = HeroService()
    private var heroId: Int
    
    init(heroId: Int, mockable: Bool = false) {
        self.heroId = heroId
        
        if mockable {
            let mock = MockApiClient().loadJSON(filename: HeroApi.heroDetail(heroId: heroId).mockFile!,
                                                type: HeroDataWrapper.self)
            self.hero = mock.data?.results?.first
        }
    }
    
    func fetchHeroDetail() async {
        do {
            let heroesModel = try await service.heroDetail(heroId: self.heroId)
            hero = heroesModel.data?.results?.first
            
        } catch let error {
            self.error = error
        }
    }
}
