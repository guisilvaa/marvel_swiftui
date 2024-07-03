//
//  HeroListViewModel.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation
import SwiftUI

@MainActor
class HeroListViewModel {
 
    @Published var heroes: [Hero] = []
    @Published var isLoading: Bool = true
}
