//
//  Comment.swift
//  Social Media App
//
//  Created by Ezra Pease on 1/29/26.
//

import Foundation

struct Comment: Codable {
    var commentId: UUID
    var body: String
    var userName: String
    var userId: UUID
    var createdDate: Date
}
