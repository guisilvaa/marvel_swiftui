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

struct Hero: Codable {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbImage: ThumbImage?
    var comics: HeroAppearence?
    var stories: HeroAppearence?
    var events: HeroAppearence?
    var series: HeroAppearence?
}

struct ThumbImage: Codable {
    
    var path: String = ""
    var imageExtension: String = ""
    
    var imagePath: String { "\(path).\(imageExtension)" }
}

struct HeroAppearence: Codable {
    
    var available: Int = 0
    var returned: Int = 0
}
