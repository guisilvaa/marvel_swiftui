//
//  HeroListViewModel.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation
import SwiftUI

@MainActor
final class CharactersListViewModel: ObservableObject {
 
    @Published var result: AsyncResultState<[CharacterModel]> = .loading
    
    var service = CharacterService()
    var characters: [CharacterModel] = []
    private var currentOffset = 0
    private var totalCharacters = 0
    private let limit = 10
    
    init(mockable: Bool = false) {
        if mockable {
            let mock = MockApiClient().loadJSON(filename: CharacterApi.characters(offset: "\(currentOffset)", limit: "\(limit)").mockFile!,
                                                type: CharacterDataWrapper.self)
            result = .success(mock.data?.results ?? [])
        }
    }
    
    func fetchCharacters(isLoadingMore: Bool = false) async {
        if !isLoadingMore {
            result = .loading
        }
        
        do {
            let charactersModel = try await service.characters(offset: "\(currentOffset)")
            let results = charactersModel.data?.results ?? []
            characters.append(contentsOf: results)
            totalCharacters = charactersModel.data?.total ?? 0
            result = .success(characters)
        } catch let error {
            result = .failure(error)
        }
    }
    
    func loadMoreCharacters(currentCharacter: CharacterModel) async {
        if let lastItem = self.characters.last, lastItem.id == currentCharacter.id,
           self.characters.count <= totalCharacters {
            currentOffset += limit
            await fetchCharacters(isLoadingMore: true)
        } else {
            result = .success(characters)
        }
    }
}

