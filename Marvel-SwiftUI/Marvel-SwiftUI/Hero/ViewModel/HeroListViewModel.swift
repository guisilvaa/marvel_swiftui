//
//  HeroListViewModel.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation
import SwiftUI

@MainActor
final class HeroListViewModel: ObservableObject {
 
    @Published var result: AsyncResultState<[Hero]> = .loading
    
    private var service = HeroService()
    
    init(mockable: Bool = false) {
        if mockable {
            let mock = MockApiClient().loadJSON(filename: HeroApi.heroes(offset: "0", limit: "10").mockFile!,
                                                type: HeroDataWrapper.self)
            result = .success(mock.data?.results ?? [])
        }
    }
    
    func fetchHeroes() async {
        result = .loading
        do {
            let heroesModel = try await service.heroes()
            result = .success(heroesModel.data?.results ?? [])
        } catch let error {
            result = .failure(error)
        }
    }
}

