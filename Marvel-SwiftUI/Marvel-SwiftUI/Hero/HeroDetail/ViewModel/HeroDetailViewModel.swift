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
    @Published var comics: [ComicModel] = []
    
    private var service = HeroService()
    private var heroId: Int
    
    init(heroId: Int, mockable: Bool = false) {
        self.heroId = heroId
        
        if mockable {
            let mock = MockApiClient().loadJSON(filename: HeroApi.heroDetail(heroId: heroId).mockFile!,
                                                type: HeroDataWrapper.self)
            let comicsMock = MockApiClient().loadJSON(filename: HeroApi.characterComics(characterId: heroId, offset: "0", limit: "10").mockFile!,
                                                type: ComicDataWrapper.self)
            self.hero = mock.data?.results?.first
            self.comics = comicsMock.data?.results ?? []
        }
    }
    
    func fetchHeroDetail() async {
        do {
            let heroesModel = try await service.heroDetail(heroId: self.heroId)
            hero = heroesModel.data?.results?.first
            await fetchCharacterComics()
        } catch let error {
            self.error = error
        }
    }
    
    func fetchCharacterComics() async {
        do {
            let comicsModel = try await service.characterComics(characterId: self.heroId)
            comics = comicsModel.data?.results ?? []
        } catch let error {
            self.error = error
        }
    }
}
