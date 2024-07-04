//
//  EndpointProvider.swift
//  Gamefic
//
//  Created by Guilherme Silva on 03/05/24.
//

import Foundation
import CryptoKit

protocol EndpointProvider {

    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var token: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }
}

extension EndpointProvider {
    
    var hash: String { "\(timeStamp)\(privateKey)\(publicKey)".md5 }
    var publicKey: String { "e480b2ae6af35844f163396c76701722" }
    var privateKey: String { "25500ebad3d6cd8cb798dc572683fd420a19ee4c" }
    var timeStamp: String { formatTimestamp() }

    var baseURL: String {
        return "https://gateway.marvel.com:443/v1/public"
    }

    var token: String {
        return ""
    }

    func asURLRequest() throws -> URLRequest {

        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = "/\(path)"
        
        if let queryItems = queryItems {
            urlComponents?.queryItems = queryItems
        }
        urlComponents?.queryItems?.append(contentsOf: [URLQueryItem(name: "ts", value: timeStamp),
                                                       URLQueryItem(name: "apikey", value: publicKey),
                                                       URLQueryItem(name: "hash", value: hash),])
        
        guard let url = urlComponents?.url else {
            throw ApiError(code: "-1", description: "Invalid url", userMessage: "UNKNOWN_SERVER_ERROR")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw ApiError(code: "-2", description: "Error encoding http body", userMessage: "UNKNOWN_SERVER_ERROR")
            }
        }
        
        print(urlRequest)
        return urlRequest
    }
    
    private func formatTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: Date())
    }
}

extension String {
    // To generate MD5 for Marvel API
    var md5: String {
        let hash = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}