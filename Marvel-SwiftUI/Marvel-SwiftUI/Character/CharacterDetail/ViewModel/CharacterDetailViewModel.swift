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
    private var comics: [ComicModel] = []
    private var currentOffset = 0
    private var totalComics = 0
    private let limit = 10
    
    init(characterId: Int, mockable: Bool = false) {
        self.characterId = characterId
        
        if mockable {
            let mock = MockApiClient().loadJSON(filename: CharacterApi.characterDetail(characterId: characterId).mockFile!,
                                                type: CharacterDataWrapper.self)
            let comicsMock = MockApiClient().loadJSON(filename: CharacterApi.characterComics(characterId: characterId, offset: "\(currentOffset)", limit: "\(limit)").mockFile!,
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
    
    func fetchCharacterComics(isLoadingMore: Bool = false) async {
        if !isLoadingMore {
            comicsResult = .loading
        }
        
        do {
            let comicsModel = try await service.characterComics(characterId: self.characterId, offset: "\(currentOffset)")
            let results = comicsModel.data?.results ?? []
            comics.append(contentsOf: results)
            totalComics = comicsModel.data?.total ?? 0
            comicsResult = .success(comics)
        } catch let error {
            comicsResult = .failure(error)
        }
    }
    
    func loadMoreComics(currentComic: ComicModel) async {
        if let lastItem = self.comics.last, lastItem.id == currentComic.id,
           self.comics.count <= totalComics {
            currentOffset += limit
            await fetchCharacterComics(isLoadingMore: true)
        } else {
            comicsResult = .success(comics)
        }
    }
}
