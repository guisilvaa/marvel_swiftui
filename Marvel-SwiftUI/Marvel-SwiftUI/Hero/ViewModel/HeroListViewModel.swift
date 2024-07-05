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
 
    @Published var heroes: [Hero] = []
    @Published var error: Error?
    
    private var service = HeroService()
    
    init(mockable: Bool = false) {
        if mockable {
            let mock = MockApiClient().loadJSON(filename: HeroApi.heroes(offset: "0", limit: "10").mockFile!,
                                                type: HeroDataWrapper.self)
            self.heroes = mock.data?.results ?? []
        }
    }
    
    func fetchHeroes() async {
        do {
            let heroesModel = try await service.heroes()
            heroes = heroesModel.data?.results ?? []
            
        } catch let error {
            self.error = error
        }
    }
}

