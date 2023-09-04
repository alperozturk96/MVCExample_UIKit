//
//  CommentRepository.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import Foundation

struct CommentRepository: CommentFetcher {
    var network: NetworkServiceProvider { NetworkService() }
    
    func fetchComments() async throws -> [Comment] {
        return try await network.fetch(type: [Comment].self, endpoint: "comments")
    }
}
