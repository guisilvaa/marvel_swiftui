//
//  HeroApi.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 04/07/24.
//

import Foundation

enum HeroApi: EndpointProvider {
    case heroes(offset: String, limit: String)
    case heroDetail(heroId: Int)
    case characterComics(characterId: Int, offset: String, limit: String)
    
    var path: String {
        switch self {
        case .heroes:
            "/characters"
        case .heroDetail(heroId: let heroId):
            "/characters/\(heroId)"
        case .characterComics(characterId: let characterId, offset: _, limit: _):
            "/characters/\(characterId)/comics"
        }
    }
    
    var method: RequestMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .heroes(offset: let offset, limit: let limit):
            [URLQueryItem(name: "offset", value: offset),
             URLQueryItem(name: "limit", value: limit)]
        case .characterComics(characterId: _, offset: let offset, limit: let limit):
            [URLQueryItem(name: "offset", value: offset),
             URLQueryItem(name: "limit", value: limit)]
        default:
            nil
        }
    }
    
    var body: [String : Any]?{
        nil
    }
    
    var mockFile: String? {
        switch self {
        case .heroes:
            "heroes_response"
        case .heroDetail:
            "hero_detail_response"
        case .characterComics:
            "character_comics_response"
        }
    }
}
