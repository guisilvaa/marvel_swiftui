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
        /*if mockable {
            let mock = MockApiClient().loadJSON(filename: NotificationApi.notifications(page: 1).mockFile!,
                                                type: NotificationsModel.self)
            self.notifications = mock.items
        }*/
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

