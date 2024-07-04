//
//  ApiClient.swift
//  Gamefic
//
//  Created by Guilherme Silva on 03/05/24.
//

import Foundation

protocol ApiProtocol {
    func asyncRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}

final class ApiClient: ApiProtocol {
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60 // seconds that a task will wait for data to arrive
        configuration.timeoutIntervalForResource = 300 // seconds for whole resource request to complete ,.
        return URLSession(configuration: configuration)
    }
    
    func asyncRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: endpoint.asURLRequest())
            return try self.manageResponse(data: data, response: response)
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError(error: .unknown)
        }
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let response = response as? HTTPURLResponse else {
            throw ApiError(code: "-3", 
                           description: "Invalid HTTP response",
                           userMessage: "UNKNOWN_SERVER_ERROR")
        }
        switch response.statusCode {
        case 200...299:
            do {
                let string = String(data: data, encoding: .utf8)!
                print("Response: \(string)")
                
                return try decoder.decode(T.self, from: data)
            } catch {
                print("‼️ Parser error", error)
                throw ApiError(error: .parse)
            }
        default:
            guard let decodedError = try? decoder.decode(ApiError.self, from: data) else {
                throw ApiError(code: "-4", 
                               description: "Unknown backend error. Parse api error ",
                               userMessage: "UNKNOWN_SERVER_ERROR")
               
            } //TODO Handle expired token
            /*if response.statusCode == 403 && decodedError.errorCode == KnownErrors.ErrorCode.expiredToken.rawValue {
                NotificationCenter.default.post(name: .terminateSession, object: self)
            }
            throw ApiError(
                statusCode: response.statusCode,
                errorCode: decodedError.errorCode,
                message: decodedError.message
            )*/
            throw ApiError(error: .unknown)
        }
    }
}
