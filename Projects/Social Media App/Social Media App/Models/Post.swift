//
//  Post.swift
//  Social Media App
//
//  Created by Ezra Pease on 1/29/26.
//

import Foundation


struct Post: Codable, Identifiable {
    var id = UUID()
    
    var postID: UUID
    var title: String
    var body: String
    var authorUserName: String
    var authorUserId: UUID
    var likes: Int
    var userLiked: Bool
    var numComments: Int
    var createdDate: Date
}
