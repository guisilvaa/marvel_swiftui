//
//  AsyncResultState.swift
//  Gamefic
//
//  Created by Guilherme Silva on 17/06/24.
//

import Foundation

enum AsyncResultState<Success> {
    case empty
    case loading
    case success(Success)
    case failure(Error)
}
