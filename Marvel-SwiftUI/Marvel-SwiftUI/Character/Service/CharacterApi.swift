//
//  HeroApi.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 04/07/24.
//

import Foundation

enum CharacterApi: EndpointProvider {
    case characters(offset: String, limit: String)
    case characterDetail(characterId: Int)
    case characterComics(characterId: Int, offset: String, limit: String)
    
    var path: String {
        switch self {
        case .characters:
            "/characters"
        case .characterDetail(characterId: let characterId):
            "/characters/\(characterId)"
        case .characterComics(characterId: let characterId, offset: _, limit: _):
            "/characters/\(characterId)/comics"
        }
    }
    
    var method: RequestMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .characters(offset: let offset, limit: let limit):
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
        case .characters:
            "characters_list_response"
        case .characterDetail:
            "character_detail_response"
        case .characterComics:
            "character_comics_response"
        }
    }
}
