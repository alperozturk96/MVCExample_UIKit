//
//  Comment.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import Foundation

struct Comment: Codable, Identifiable {
    var uuid = UUID()
    let postId, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postId = "postId"
        case id, name, email, body
    }
}
