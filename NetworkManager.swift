//
//  SecondNetworkManager.swift
//  SpaceX
//
//  Created by iOS Parti on 8/10/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func performRequest<T: Decodable>(apiConfig: APIConfigProtocol) async throws -> T
}

struct NetworkManager {
    //MARK: Variable
    private let session: URLSession

    //MARK: LifeCycle
    init(session: URLSession = .shared) {
        self.session = session
    }

    //MARK: Function
    private func buildURLRequest(apiConfig: APIConfigProtocol) throws -> URLRequest {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String else { throw NetworkError.invalidURL }
        guard var components = URLComponents(string: baseURL + apiConfig.url) else {
            throw NetworkError.invalidURL
        }
        
        if let queryParameters = apiConfig.queryParameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = components.url else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = apiConfig.timeoutInterval
        request.httpMethod = apiConfig.method.rawValue
        request.cachePolicy = apiConfig.cachePolicy
        request.allHTTPHeaderFields = apiConfig.header
        
        if let body = apiConfig.body {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let encoded = try encoder.encode(body)
            request.httpBody = encoded
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    private func makeRequest(request: URLRequest) async throws -> HTTPResponse<Data> {
        let (data, response) = try await session.data(for: request)
        let httpResponse = HTTPResponse(data: data, response: response)
        guard let httpResponseHandler = httpResponse.response as? HTTPURLResponse, 200..<300 ~= httpResponseHandler.statusCode else {
            throw NetworkError.invalidResponse(statusCode: (httpResponse.response as? HTTPURLResponse)?.statusCode)
        }
        return httpResponse
    }
    
    private func decodeRequest<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func performRequest<T: Decodable>(apiConfig: APIConfigProtocol) async throws -> T {
        let request = try buildURLRequest(apiConfig: apiConfig)
        
        let httpResponse = try await makeRequest(request: request)
        let decodedData: T = try decodeRequest(data: httpResponse.data)
        return decodedData
    }
}
