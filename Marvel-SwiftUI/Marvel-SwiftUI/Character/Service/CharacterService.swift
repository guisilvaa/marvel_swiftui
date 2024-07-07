//
//  HeroService.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation

final class CharacterService {
    
    let apiClient: ApiProtocol
    
    init(apiClient: ApiProtocol = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func characters(offset: String = "0", limit: String = "10") async throws -> CharacterDataWrapper {
        try await apiClient.asyncRequest(endpoint: CharacterApi.characters(offset: offset, limit: limit),
                                         responseModel: CharacterDataWrapper.self)
    }
    
    func characterDetail(characterId: Int) async throws -> CharacterDataWrapper {
        try await apiClient.asyncRequest(endpoint: CharacterApi.characterDetail(characterId: characterId),
                                         responseModel: CharacterDataWrapper.self)
    }
    
    func characterComics(characterId: Int,
                         offset: String = "0", 
                         limit: String = "10") async throws -> ComicDataWrapper {
        try await apiClient.asyncRequest(endpoint: CharacterApi.characterComics(characterId: characterId, offset: offset, limit: limit),
                                         responseModel: ComicDataWrapper.self)
    }
}
