//
//  Router.swift
//  Marvel-SwiftUI
//
//  Created by Guilherme Silva on 23/01/24.
//

import Foundation
import CryptoKit

enum Router: Equatable {
    case heroes(offset: String = "0", limit: String = "10")

    var url: String {scheme + "://" + host + path}
    var scheme: String {API.scheme}
    var host: String {API.URL}

    var path: String {
        switch self {
        case .heroes:
            return "/characters"

        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .heroes(let offset, let limit):
            return [URLQueryItem(name: "ts", value: API.timeStamp),
                    URLQueryItem(name: "apikey", value: API.publicKey),
                    URLQueryItem(name: "hash", value: API.hash),
                    URLQueryItem(name: "limit", value: limit),
                    URLQueryItem(name: "offset", value: offset )]
        }
    }

    var method: String {
        switch self {
        case .heroes:
            return "GET"
        }
    }

}

struct API {
    static var hash: String { "\(timeStamp)\(privateKey)\(publicKey)".md5 }
    static var publicKey: String { "e480b2ae6af35844f163396c76701722" }
    static var privateKey: String { "25500ebad3d6cd8cb798dc572683fd420a19ee4c" }
    static var timeStamp: String { formatter.string(from: Date()) }
    static var schemeURL: String {scheme + "://" + URL}
    static var scheme: String {return "https"}
    static var URL: String {
        "gateway.marvel.com:443/v1/public"
    }

    private static let formatter: DateFormatter = {
        let form = DateFormatter()
        form.dateFormat = "yyyyMMddHHmmss"
          return form
          }()

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
