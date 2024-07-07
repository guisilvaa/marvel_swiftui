//
//  HeroService.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation

final class HeroService {
    
    let apiClient: ApiProtocol
    
    init(apiClient: ApiProtocol = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func heroes(offset: String = "0", limit: String = "10") async throws -> HeroDataWrapper {
        try await apiClient.asyncRequest(endpoint: HeroApi.heroes(offset: offset, limit: limit),
                                         responseModel: HeroDataWrapper.self)
    }
    
    func heroDetail(heroId: Int) async throws -> HeroDataWrapper {
        try await apiClient.asyncRequest(endpoint: HeroApi.heroDetail(heroId: heroId),
                                         responseModel: HeroDataWrapper.self)
    }
    
    func characterComics(characterId: Int,
                         offset: String = "0", 
                         limit: String = "10") async throws -> ComicDataWrapper {
        try await apiClient.asyncRequest(endpoint: HeroApi.characterComics(characterId: characterId, offset: offset, limit: limit),
                                         responseModel: ComicDataWrapper.self)
    }
}
