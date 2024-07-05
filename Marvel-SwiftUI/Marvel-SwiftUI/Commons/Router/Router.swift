//
//  Router.swift
//  Gamefic
//
//  Created by Guilherme Silva on 08/05/24.
//

import SwiftUI

final class Router: ObservableObject {
    
    enum Route: Hashable {
        case heroes
        case heroDetail(heroId: Int)
    }
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .heroes:
            HeroesView()
        case .heroDetail(heroId: let heroId):
            HeroDetailView(heroId: heroId)
        }
    }
    
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
}
