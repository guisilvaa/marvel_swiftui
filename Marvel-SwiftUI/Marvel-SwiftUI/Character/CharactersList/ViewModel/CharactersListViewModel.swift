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
    
    private var service = CharacterService()
    
    init(mockable: Bool = false) {
        if mockable {
            let mock = MockApiClient().loadJSON(filename: CharacterApi.characters(offset: "0", limit: "10").mockFile!,
                                                type: CharacterDataWrapper.self)
            result = .success(mock.data?.results ?? [])
        }
    }
    
    func fetchCharacters() async {
        result = .loading
        do {
            let charactersModel = try await service.characters()
            result = .success(charactersModel.data?.results ?? [])
        } catch let error {
            result = .failure(error)
        }
    }
}

