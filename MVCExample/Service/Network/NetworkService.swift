//
//  NetworkService.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import Foundation

final class NetworkService: NetworkServiceProvider {
    
    internal let baseUrl: String = AppEnvironment.baseUrl
    
    internal lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    func fetch<T: Decodable>(type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        print("Fetching response")
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
