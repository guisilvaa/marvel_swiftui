//
//  HeroService.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation

struct HeroService: HTTPClient {
    func getHeroes(offset: String = "0", limit: String = "10") async throws -> HeroDataWrapper {
        return try await sendRequest(endpoint: .heroes(offset: offset), responseModel: HeroDataWrapper.self)
    }
}
