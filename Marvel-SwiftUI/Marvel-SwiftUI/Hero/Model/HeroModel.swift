//
//  HeroModel.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation

struct HeroDataWrapper: Codable {
    
    var data: HeroDataContainer?
}

struct HeroDataContainer: Codable {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [Hero]?
}

struct Hero: Codable, Hashable, Identifiable {
    var identifier: String {
        return UUID().uuidString
    }
        
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: ThumbImage?
    var comics: HeroAppearence?
    var stories: HeroAppearence?
    var events: HeroAppearence?
    var series: HeroAppearence?
}

struct ThumbImage: Codable {
    
    var path: String = ""
    var thumbnailExtension: String = ""
    
    var imagePath: String { "\(path).\(thumbnailExtension)" }
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

struct HeroAppearence: Codable {
    
    var available: Int = 0
    var returned: Int = 0
    var items: [CharacterAppearenceItemModel]
}

struct CharacterAppearenceItemModel: Codable, Identifiable {
    var id: String {
        return UUID().uuidString
    }
    
    var name, resourceURI: String
}
