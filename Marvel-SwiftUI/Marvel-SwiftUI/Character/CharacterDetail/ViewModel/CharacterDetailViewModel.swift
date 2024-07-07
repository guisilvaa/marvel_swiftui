//
//  HeroDetailViewModel.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 05/07/24.
//

import Foundation
import SwiftUI

@MainActor
final class CharacterDetailViewModel: ObservableObject {
   
    @Published var result: AsyncResultState<CharacterModel?> = .loading
    @Published var comicsResult: AsyncResultState<[ComicModel]> = .loading
    
    private var service = CharacterService()
    private var characterId: Int
    
    init(characterId: Int, mockable: Bool = false) {
        self.characterId = characterId
        
        if mockable {
            let mock = MockApiClient().loadJSON(filename: CharacterApi.characterDetail(characterId: characterId).mockFile!,
                                                type: CharacterDataWrapper.self)
            let comicsMock = MockApiClient().loadJSON(filename: CharacterApi.characterComics(characterId: characterId, offset: "0", limit: "10").mockFile!,
                                                type: ComicDataWrapper.self)
            result = .success(mock.data?.results?.first)
            comicsResult = .success(comicsMock.data?.results ?? [])
        }
    }
    
    func fetchCharacterDetail() async {
        result = .loading
        do {
            let charactersModel = try await service.characterDetail(characterId: self.characterId)
            result = .success(charactersModel.data?.results?.first)
            await fetchCharacterComics()
        } catch let error {
            result = .failure(error)
        }
    }
    
    func fetchCharacterComics() async {
        comicsResult = .loading
        do {
            let comicsModel = try await service.characterComics(characterId: self.characterId)
            comicsResult = .success(comicsModel.data?.results ?? [])
        } catch let error {
            comicsResult = .failure(error)
        }
    }
}
