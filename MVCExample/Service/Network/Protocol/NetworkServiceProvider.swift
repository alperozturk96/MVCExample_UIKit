//
//  NetworkServiceProvider.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import Foundation

protocol NetworkServiceProvider {
    var baseUrl: String { get }
    var urlSession: URLSession { get }
    
    func fetch<T: Decodable>(type: T.Type, endpoint: String) async throws -> T
}
