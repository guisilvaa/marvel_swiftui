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
    var message: String

    init(code: String, description: String, userMessage: String, message: String) {
        self.code = code
        self.description = description
        self.userMessage = userMessage
        self.message = message
    }
    
    init(error: ApiErrorType) {
        self.code = error.rawValue
        self.description = error.description()
        self.userMessage = error.localizedMessage()
        self.message = error.localizedMessage()
    }

    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}

extension ApiError: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        userMessage = ""
        description = ""
    }
}
