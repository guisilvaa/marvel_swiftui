//
//  ComicModel.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 07/07/24.
//

import Foundation

struct ComicDataWrapper: Codable {
    
    var data: ComicDataContainer?
}

struct ComicDataContainer: Codable {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [ComicModel]?
}

struct ComicModel: Codable, Hashable, Identifiable {
    var identifier: String {
        return UUID().uuidString
    }
        
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
    
    static func == (lhs: ComicModel, rhs: ComicModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int?
    var title: String?
    var description: String?
    let modified: String?
    let isbn, upc, diamondCode, ean: String?
    let issn, format: String?
    var thumbnail: ComicThumbImage?
}

struct ComicThumbImage: Codable {
    
    var path: String = ""
    var thumbnailExtension: String = ""
    
    var imagePath: String { "\(path).\(thumbnailExtension)" }
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
