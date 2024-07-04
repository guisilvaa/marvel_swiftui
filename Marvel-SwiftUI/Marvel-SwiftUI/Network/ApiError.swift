//
//  ApiError.swift
//  Gamefic
//
//  Created by Guilherme Silva on 03/05/24.
//

import Foundation

struct ApiError: Error {

    var code: String
    var description: String
    var userMessage: String

    init(code: String, description: String, userMessage: String) {
        self.code = code
        self.description = description
        self.userMessage = userMessage
    }
    
    init(error: ApiErrorType) {
        self.code = error.rawValue
        self.description = error.description()
        self.userMessage = error.localizedMessage()
    }

    private enum CodingKeys: String, CodingKey {
        case code
        case description
        case userMessage
    }
}

extension ApiError: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        description = try container.decode(String.self, forKey: .description)
        userMessage = try container.decode(String.self, forKey: .userMessage)
    }
}
