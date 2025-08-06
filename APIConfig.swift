//
//  APIConfig.swift
//  SpaceX
//
//  Created by Amir on 8/12/23.
//

import Foundation

protocol APIConfigProtocol {
    var url: String { get}
    var method: RequestMethod { get}
    var header: [String: String] { get }
    var queryParameters: [String: String]? { get }
    var body: Encodable? { get }
    var timeoutInterval: Double { get}
    var cachePolicy: URLRequest.CachePolicy { get}
}

extension APIConfigProtocol {
    var timeoutInterval: Double {
        return 30
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
    
    var body: Encodable? {
        return nil
    }
    
    var queryParameters: [String: String]? {
        return nil
    }
}
