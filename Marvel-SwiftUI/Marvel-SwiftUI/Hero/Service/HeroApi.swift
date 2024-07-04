//
//  HeroApi.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 04/07/24.
//

import Foundation

enum HeroApi: EndpointProvider {
    case heroes(offset: String, limit: String)
    
    var path: String {
        switch self {
        case .heroes:
            "/characters"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .heroes:
            .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .heroes(offset: let offset, limit: let limit):
            [URLQueryItem(name: "offset", value: offset),
             URLQueryItem(name: "limit", value: limit)]
        }
    }
    
    var body: [String : Any]?{
        nil
    }
    
    var mockFile: String? {
        switch self {
        case .heroes:
            "heroes_response"
        }
    }
}
