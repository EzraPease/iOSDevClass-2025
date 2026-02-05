//
//  Post.swift
//  Social Media App
//
//  Created by Ezra Pease on 1/29/26.
//

import Foundation

/// Matches `PostResponseDTO` from the API.
struct Post: Codable, Identifiable {
    /// Use `postID` as the stable `Identifiable` key.
    var id: UUID { postID }
    
    let postID: UUID
    let title: String
    let body: String
    let authorUserName: String
    let authorUserId: UUID
    let likes: Int
    let userLiked: Bool
    let numComments: Int
    let createdDate: Date
}
