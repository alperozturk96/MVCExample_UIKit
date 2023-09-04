//
//  CommentFetcher.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import Foundation

protocol CommentFetcher {
    var network: NetworkServiceProvider { get }
    func fetchComments() async throws -> [Comment]
}
