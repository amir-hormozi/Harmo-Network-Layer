//
//  NetworkError.swift
//  SpaceX
//
//  Created by Amir on 8/12/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse(statusCode: Int?)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .requestFailed(let error): return "Request failed: \(error.localizedDescription)"
        case .invalidResponse(let code): return "Server error with status code: \(String(describing: code))"
        case .decodingError(let error): return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}
