//
//  ApiErrorType.swift
//  Gamefic
//
//  Created by Guilherme Silva on 03/05/24.
//

import Foundation

enum ApiErrorType: String {
    
    case connection = "NO_CONNECTION"
    case parse = "PARSE_RESPONSE"
    case unauthorized = "UNAUTHORIZED"
    case timeout = "TIMEOUT"
    case unknown = "UNKNOWN"
    
    func description() -> String {
        switch self {
        case .connection:
            return "No internet connection"
        case .parse:
            return "Fail to parse object"
        case .unauthorized:
            return "Fail to refresh token"
        case .timeout:
            return "Request time out"
        case .unknown:
            return "Unknown error"
        }
    }
    
    func localizedMessage() -> String {
        switch self {
        case .connection:
            return "Unable to connect. Check your internet connection and try again"
        case .parse:
            return "UNKNOWN_SERVER_ERROR"
        case .unauthorized:
            return "UNAUTHORIZED_ERROR"
        case .timeout:
            return "TIMEOUT_ERROR"
        case .unknown:
            return "UNKNOWN_SERVER_ERROR"
        }
    }
}
