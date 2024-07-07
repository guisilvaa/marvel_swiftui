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
   
    @Published var result: AsyncResultState<Hero?> = .loading
    @Published var comicsResult: AsyncResultState<[ComicModel]> = .loading
    
    private var service = HeroService()
    private var heroId: Int
    
    init(heroId: Int, mockable: Bool = false) {
        self.heroId = heroId
        
        if mockable {
            let mock = MockApiClient().loadJSON(filename: HeroApi.heroDetail(heroId: heroId).mockFile!,
                                                type: HeroDataWrapper.self)
            let comicsMock = MockApiClient().loadJSON(filename: HeroApi.characterComics(characterId: heroId, offset: "0", limit: "10").mockFile!,
                                                type: ComicDataWrapper.self)
            result = .success(mock.data?.results?.first)
            comicsResult = .success(comicsMock.data?.results ?? [])
        }
    }
    
    func fetchHeroDetail() async {
        result = .loading
        do {
            let heroesModel = try await service.heroDetail(heroId: self.heroId)
            result = .success(heroesModel.data?.results?.first)
            await fetchCharacterComics()
        } catch let error {
            result = .failure(error)
        }
    }
    
    func fetchCharacterComics() async {
        comicsResult = .loading
        do {
            let comicsModel = try await service.characterComics(characterId: self.heroId)
            comicsResult = .success(comicsModel.data?.results ?? [])
        } catch let error {
            comicsResult = .failure(error)
        }
    }
}
